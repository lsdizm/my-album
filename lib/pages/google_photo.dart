import 'package:flutter/material.dart';
import '../models/album_item.dart';

class GooglePhoto extends StatefulWidget {
  const GooglePhoto({super.key});

  @override
  _GooglePhotoState createState() => _GooglePhotoState();
}

class _GooglePhotoState extends State<GooglePhoto> {
  // List<AssetEntity> mediaList = [];
  List<AlbumItem> mediaList = [];

  @override
  void initState() {
    super.initState();
    // fetchMedia();
  }
/*
  void fetchMedia() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(type: RequestType.image);
      List<AssetEntity> media =
          await albums[0].getAssetListRange(start: 0, end: 100);
      setState(() {
        mediaList = media;
      });
    } else {
      // 권한 거부 시 처리
    }
  }
*/
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Photos'),
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: mediaList.length,
        itemBuilder: (context, index) {
          return FutureBuilder<AlbumItem>(
            future: mediaList[index].thumbnailData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Image.memory(snapshot.data!, fit: BoxFit.cover);
              }
              return const CircularProgressIndicator();
            },
          );
        },
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // title: Text('Dashboard'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab 3'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Dashboard Tab 1')),
            Center(child: Text('Dashboard Tab 2')),
            Center(child: Text('Dashboard Tab 3')),
          ],
        ),
      ),
    );
  }

}
