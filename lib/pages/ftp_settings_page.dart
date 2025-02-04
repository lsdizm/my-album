import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class FtpSettingsPage extends StatefulWidget {
  @override
  _FtpSettingsPageState createState() => _FtpSettingsPageState();
}

class _FtpSettingsPageState extends State<FtpSettingsPage> {
  final TextEditingController _ftpUrlController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _ftpUrlController.text = prefs.getString('ftp_url') ?? '';
      _usernameController.text = prefs.getString('ftp_username') ?? '';
      _passwordController.text = prefs.getString('ftp_password') ?? '';
    });
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ftp_url', _ftpUrlController.text);
    await prefs.setString('ftp_username', _usernameController.text);
    await prefs.setString('ftp_password', _passwordController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('설정이 저장되었습니다.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FTP 설정')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _ftpUrlController,
              decoration: InputDecoration(labelText: 'FTP 주소'),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: '아이디'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSettings,
              child: Text('저장하기'),
            ),
          ],
        ),
      ),
    );
  }
}

class FtpVideoPlayer extends StatefulWidget {
  @override
  _FtpVideoPlayerState createState() => _FtpVideoPlayerState();
}

class _FtpVideoPlayerState extends State<FtpVideoPlayer> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _loadFtpSettings();
  }

  Future<void> _loadFtpSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ftpUrl = prefs.getString('ftp_url') ?? '';
    if (ftpUrl.isNotEmpty) {
      _controller = VideoPlayerController.network(ftpUrl)
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FTP 동영상 재생')),
      body: Center(
        child: _controller != null && _controller!.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
