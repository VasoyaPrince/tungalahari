import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tungalahari/albumItems.dart';
import 'package:tungalahari/localeString.dart';
import 'package:tungalahari/model/album.dart';

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
      locale: const Locale('en ', 'US'),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: ScrollBehaviour(),
          child: child!,
        );
      },
      theme: ThemeData(
          primarySwatch: Colors.red,
          primaryTextTheme: const TextTheme(
              titleMedium: TextStyle(
            color: Colors.white,
          ))),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(
        title: 'Collapsing Toolbar',
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
                stretchModes: const <StretchMode>[
                  StretchMode.fadeTitle,
                ],
                centerTitle: false,
                // title: const Text(
                //   "Collapsing Toolbar",
                //   style: TextStyle(
                //     color: Colors.white,
                //   ),
                // ),
                background: Image.network(
                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPersistentHeader(pinned: true, delegate: Delegate())
          ];
        },
        body: isData != true
            ? const CircularProgressIndicator()
            : GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                padding: const EdgeInsets.all(10),
                children: List.generate(
                  albums!.length,
                  (index) {
                    return Center(
                      child: AlbumItems(
                        album: albums![index],
                      ),
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
        children: const [
          SizedBox(
            width: 10,
          ),
          Expanded(child: Text("Select Language")),
          SizedBox(
            width: 140,
          ),
          Expanded(child: DropdownButtonExample()),
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
      isExpanded: false,
      alignment: AlignmentDirectional.center,
      underline: Container(),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;

          if (value == "English") {
            var locale = const Locale('en', 'US');
            Get.updateLocale(locale);
          } else if (value == "Hindi") {
            var locale = const Locale('hi', 'IN');
            Get.updateLocale(locale);
          } else if (value == "Kannada") {
            var locale = const Locale('kn', 'IN');
            Get.updateLocale(locale);
          } else if (value == "Tamil") {
            var locale = const Locale('tm', 'IN');
            Get.updateLocale(locale);
          } else if (value == "Telugu") {
            var locale = const Locale('tg', 'IN');
            Get.updateLocale(locale);
          }
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

Future<List<Album>> fetchAlbum() async {
  await Future.delayed(const Duration(seconds: 2));
  return List<Album>.from(songs.map((e) => Album.fromJson(e)));
}

List<Map<String, dynamic>> songs = [
  {
    'Image':
        'https://djmaza.live/siteuploads/thumb/c/422_resize2x_200x200.webp',
    'Title': 'Pathaan ',
    'Songs': [
      {
        'Name': 'Jhoome Jo Pathaan',
        'subtitle': 'Jhoome Jo Pathaan',
        'duration': '3:28',
        'url':
            'https://djmaza.live/siteuploads/files/sfd18/8665/Jhoome%20Jo%20Pathaan-(DJMaza).mp3',
        'singerName': ' Arijit Singh, Sukriti Kakar',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'Besharam Rang',
        'subtitle': 'Besharam Rang',
        'duration': '4:19',
        'url':
            'https://djmaza.live/siteuploads/files/sfd17/8409/Besharam%20Rang%20-%20Pathaan-(DJMaza).mp3',
        'singerName':
            'Shilpa Rao, Caralisa Monteiro,\n Vishal Dadlani, Shekhar Ravjiani',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
    ],
  },
  {
    'Image':
        'https://djmaza.live/siteuploads/thumb/sft19/9318_resize2x_200x200.webp',
    'Title': 'Yo Yo Honey Singh',
    'Songs': [
      {
        'Name': 'Jaam ',
        'subtitle': 'Jaam Jaam',
        'duration': '3:22',
        'url':
            'https://djmaza.live/siteuploads/files/sfd19/9318/Jaam%20(Yo%20Yo%20Honey%20Singh)%20-%20Bass%20Yogi%20Remix-(DJMaza).mp3',
        'singerName': 'Yo Yo Honey Singh',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'Mere Mehboob Qayamat Hogi',
        'subtitle': 'Yo Yo Honey Singh',
        'duration': '3:14',
        'url':
            'https://djmaza.live/siteuploads/files/sfd19/9055/Mere%20Mehboob%20Qayamat%20Hogi%20-%20Yo%20Yo%20Honey%20Singh-(DJMaza).mp3',
        'singerName': 'Yo Yo Honey Singh',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
    ],
  },
  {
    'Image': 'https://djmaza.live/siteuploads/thumb/sft16/7625_resize2x_200x200.webp',
    'Title': 'Hurts So Good',
    'Songs': [
      {
        'Name': 'Hurts So Good',
        'subtitle': 'Hurts So Good',
        'duration': '3:29',
        'url': 'https://djmaza.live/siteuploads/files/sfd16/7625/Hurts%20So%20Good-(DJMaza).mp3',
        'singerName': ' Astrid S',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
    ],
  },
  {
    'Image': 'https://picsum.photos/250?image=112',
    'Title': 'xyz',
    'Songs': [
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
    ],
  },
  {
    'Image': 'https://picsum.photos/250?image=112',
    'Title': 'xyz',
    'Songs': [
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
    ],
  },
  {
    'Image': 'https://picsum.photos/250?image=112',
    'Title': 'xyz',
    'Songs': [
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
    ],
  },
  {
    'Image': 'https://picsum.photos/250?image=112',
    'Title': 'xyz',
    'Songs': [
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
    ],
  },
  {
    'Image': 'https://picsum.photos/250?image=112',
    'Title': 'xyz',
    'Songs': [
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
    ],
  },
  {
    'Image': 'https://picsum.photos/250?image=112',
    'Title': 'xyz',
    'Songs': [
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
    ],
  },
  {
    'Image': 'https://picsum.photos/250?image=112',
    'Title': 'xyz',
    'Songs': [
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
      {
        'Name': 'xyz',
        'subtitle': 'xyz',
        'duration': 'xyz',
        'url': 'xyz',
        'singerName': 'xyz',
        'songLayers': """
        <p>You're fighting me off like a firefighter</p>
         <p>So tell me why you still get burned</p>
         <p>You say you're not, but you're still a liar</p>
         <p>'Cause I'm the one that you run to first</p>
         <p>Every time, yeah</p>
         <p>Why do you try to deny it</p>
         <p>When you show up every night</p>
         <p>And tell me that you want me but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it? </p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good</p>
         <p>Every time that I swear it's over</p>
         <p>It makes you want me even more</p>
         <p>You pull away and I come in closer</p>
         <p>And all we ever stay is torn</p>
         <p>And baby, I don't know</p>
         <p>Why I try to deny it</p>
         <p>When you show up every night</p>
         <p>I tell you that I want you but it's complicated</p>
         <p>So complicated</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good</p>
         <p>Wide awake through the daylight</p>
         <p>Will you hold me like we're running a yellow light?</p>
         <p>Reach for you with my hands tied</p>
         <p>Are we dancing like we're burning in paradise?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Do you take it?</p>
         <p>Do you break it off?</p>
         <p>When it hurts but it hurts so good</p>
         <p>Can you say it?</p>
         <p>Can you say it?</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>Ooh, it hurts so good (hey, na-na-na, na-na)</p>
         <p>Your love is like (hey, na-na-na, na-na)</p>
         <p>It hurts so good </p>
         """,
      },
    ],
  },
];
