import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tungalahari/albumItems.dart';
import 'package:tungalahari/localeString.dart';

void main() {
  runApp(const MyApp());
}

const List<String> list = <String>[
  'English',
  'Hindi',
  'Kannada',
  'Tamil',
  'Telugu'
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: LocaleString(),
      locale: Locale('en ', 'US'),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: ScrollBehaviour(),
          child: child!,
        );
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              titleSpacing: 0.0,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: const Text(
                  "Collapsing Toolbar",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                background: Image.network(
                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPersistentHeader(pinned: true, delegate: Delegate())
          ];
        },
        body: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          padding: EdgeInsets.all(10),
          children: List.generate(
            10,
            (index) {
              return Center(
                child: AlbumItems(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(child: Text("Select Language")),
          Expanded(child: DropdownButtonExample()),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 30;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_sharp),
      elevation: 8,
      style: const TextStyle(color: Colors.black),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;

          if (value == "English") {
            var locale = Locale('en', 'US');
            Get.updateLocale(locale);
          } else if (value == "Hindi") {
            var locale = Locale('hi', 'IN');
            Get.updateLocale(locale);
          } else if (value == "Kannada") {
            var locale = Locale('kn', 'IN');
            Get.updateLocale(locale);
          }  else if (value == "Tamil") {
            var locale = Locale('tm', 'IN');
            Get.updateLocale(locale);
          } else if (value == "Telugu")  {
            var locale = Locale('tg', 'IN');
            Get.updateLocale(locale);
          }
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class ScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
