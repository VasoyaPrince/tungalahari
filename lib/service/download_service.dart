import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadService {
  final ReceivePort _port = ReceivePort();
  final StreamController<TaskInfo> _downloadTask =
      StreamController<TaskInfo>.broadcast();

  Stream<TaskInfo> get downloadTaskStream => _downloadTask.stream;

  DownloadService._() {
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback, step: 1);
  }

  static DownloadService? _instance;

  factory DownloadService() {
    return _instance ??= DownloadService._();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((data) async {
      log("Progress: ${data[2]}");
      String id = data[0] as String;
      DownloadTaskStatus status = DownloadTaskStatus(data[1] as int);
      int progress = data[2] as int;

      if (status == DownloadTaskStatus.complete) {
        Fluttertoast.showToast(msg: "Downloaded");
      } else if (status == DownloadTaskStatus.failed) {
        await FlutterDownloader.remove(taskId: id);
      }
      _downloadTask
          .add(TaskInfo(taskId: id, status: status, progress: progress));
    });
  }

  void dispose() {
    _downloadTask.close();
    _unbindBackgroundIsolate();
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  Future<void> cancelDownload(String taskId) async {
    await FlutterDownloader.cancel(taskId: taskId);
  }

  Future<bool> downloadFile(TaskInfo task, String fileName) async {
    Directory dir;
    try {
      if (await _checkPermission()) {
        dir = await _prepareSaveDir();
      } else {
        return false;
      }
      log("path ${dir.path}");
      Fluttertoast.showToast(msg: "Downloading");
      await _requestDownload(task, dir.path, fileName);
      return true;
    } catch (e) {
      log('$e');
    }
    return false;
  }

  Future<bool> _checkPermission() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo? androidInfo;
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    }
    if (androidInfo != null && androidInfo.version.sdkInt <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<Directory> _prepareSaveDir() async {
    String localPath = await _findLocalPath();
    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    return savedDir;
  }

  Future<void> _requestDownload(
      TaskInfo task, String path, String fileName) async {
    task.taskId = await FlutterDownloader.enqueue(
      url: task.link!,
      // headers: {"auth": "test_for_sql_encoding"},
      savedDir: path,
      showNotification: true,
      fileName: fileName,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
  }

  Future<String> _findLocalPath() async {
    String externalStorageDirPath = '';
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path ?? '';
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
          String id, DownloadTaskStatus status, int progress) =>
      IsolateNameServer.lookupPortByName('downloader_send_port')
          ?.send([id, status.value, progress]);
}

class TaskInfo {
  final String? link;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;

  TaskInfo({this.link, this.taskId, this.progress, this.status});

  @override
  bool operator ==(Object other) => other is TaskInfo && taskId == other.taskId;

  @override
  int get hashCode => taskId.hashCode;
}
