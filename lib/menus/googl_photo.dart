import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class GooglePhotosScreen extends StatefulWidget {
  const GooglePhotosScreen({super.key});

  @override
  _GooglePhotosScreenState createState() => _GooglePhotosScreenState();
}

class _GooglePhotosScreenState extends State<GooglePhotosScreen> {
  List<AssetEntity> mediaList = [];

  @override
  void initState() {
    super.initState();
    fetchMedia();
  }

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
          return FutureBuilder<Uint8List?>(
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
}
