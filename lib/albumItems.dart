import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tungalahari/album_page.dart';

class AlbumItems extends StatelessWidget {
  const AlbumItems({
    Key? key,
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
                  'https://picsum.photos/250?image=112',
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
                      child: Text("Title".tr,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18)),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Total Songs".tr,
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
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AlbumPage()));
  }
}
