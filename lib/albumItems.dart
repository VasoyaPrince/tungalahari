import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tungalahari/album_page.dart';
import 'package:tungalahari/model/album.dart';

class AlbumItems extends StatelessWidget {
  final Album album;

  const AlbumItems({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToNextScreen(context),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Image.network(
                  album.image!,
                  fit: BoxFit.cover,
                  // height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(album.title!.tr,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15)),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "${album.totalSongs?.length} ${'Total Songs'.tr}",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 10)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            AlbumPage(totalSongs: album.totalSongs, albumImage: album.image)));
  }
}
