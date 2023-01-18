import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tungalahari/song.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              floating: false,
              titleSpacing: 0.0,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: Image.network(
                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              elevation: 5,
              child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$index",
                      ),
                    ],
                  ),
                  title: Text("Song Name".tr),
                  subtitle: Text("subtitle".tr),
                  trailing: Text("12:90"),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Song()));
                  }),
            );
          },
        ),
      ),
    );
  }
}
