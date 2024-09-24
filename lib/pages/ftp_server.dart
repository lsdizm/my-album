import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FtpServer extends StatefulWidget {
  const FtpServer({super.key});

  @override
  _FtpServerState createState() => _FtpServerState();
}

class _FtpServerState extends State<FtpServer> {
  @override
  void initState() {
    super.initState();
  }

  final List<Map<String, String>> files = [
    {"name": "Image 1", "path": "../asset/image_test.jpg", "type": "image"},
    {"name": "video 1", "path": "../asset/video_test.mp4", "type": "video"},    
  ];
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File List'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              files[index]["name"]!,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              if (files[index]["type"] == "image") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ImageViewerScreen(imagePath: files[index]["path"]!),
                  ),
                );
              } else if (files[index]["type"] == "video") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VideoViewerScreen(videoPath: files[index]["path"]!),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}


class ImageViewerScreen extends StatelessWidget {
  final String imagePath;

  ImageViewerScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Image.asset(imagePath), // 이미지를 표시하는 위젯
      ),
    );
  }
}

class VideoViewerScreen extends StatefulWidget {
  final String videoPath;

  VideoViewerScreen({required this.videoPath});

  @override
  _VideoViewerScreenState createState() => _VideoViewerScreenState();
}

class _VideoViewerScreenState extends State<VideoViewerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {}); // 동영상 초기화 후 화면 갱신
        _controller.play(); // 자동 재생
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // 동영상 플레이어 리소스 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Viewer'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(), // 동영상 로딩 중 표시
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}