import 'dart:convert';
import 'package:Tungalahari/albumItems.dart';
import 'package:Tungalahari/localeString.dart';
import 'package:Tungalahari/model/album.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color(0xFFB71C1C)));
  runApp(const MyApp());
}

const List<String> list = <String>[
  'English',
  'Devanagari',
  'Kannada',
  'Tamil',
  'Telugu',
  'Gujarati',
  'Malayalam'
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: LocaleString(),
      locale: const Locale('en ', 'US'),
      // builder: (context, child) {
      //   return ScrollConfiguration(
      //     behavior: ScrollBehaviour(),
      //     child: child!,
      //   );
      // },
      theme: ThemeData(
          primarySwatch: Colors.red,
          primaryTextTheme: const TextTheme(
              titleMedium: TextStyle(
            color: Colors.white,
          ))),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(
        title: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Album>? albums;
  bool isData = false;
  String dropdownValue = list.first;

  @override
  void initState() {
    super.initState();
    albumData();
  }

  Future<void> albumData() async {
    albums = await fetchAlbum();
    setState(() {
      isData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - 315) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: 250),
              pinned: true,
            ),
            SliverPersistentHeader(
              delegate: Delegate(
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      const Expanded(child: Text("Select Language")),
                      const SizedBox(width: 140),
                      Expanded(
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          elevation: 8,
                          isExpanded: false,
                          alignment: AlignmentDirectional.center,
                          underline: Container(),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: list.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                enabled: true,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                height: 30,
              ),
              pinned: true,
            ),
            if (isData)
              SliverGrid.builder(
                itemCount: albums!.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 270,
                  mainAxisExtent: 230,
                  crossAxisSpacing: 5,
                  childAspectRatio: (itemWidth / itemHeight),
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return AlbumItems(
                    album: albums![index],
                    language: dropdownValue,
                  );
                },
              )
            else
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  Delegate({required this.child, required this.height});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class ScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Future<List<Album>> fetchAlbum() async {
  var input = await rootBundle.loadString('assets/albums.json');
  final data = json.decode(input);
  return List<Album>.from(data['albums'].map((e) => Album.fromJson(e)));
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/cover.jpg',
          fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tungalahari".toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              "Sharda peetham Sringeri",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Opacity(
          opacity: shrinkOffset / expandedHeight,
          child: Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 8, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    "Tungalahari",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
