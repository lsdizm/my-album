import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GooglePhoto extends StatefulWidget {
  const GooglePhoto({super.key});

  @override
  _GooglePhotoState createState() => _GooglePhotoState();
}

class _GooglePhotoState extends State<GooglePhoto> {
  GoogleSignInAccount? _currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '2581038435-gshiakiumrjmvoiaarjvueb1o8353e5k.apps.googleusercontent.com',
    scopes: [
      'email',
      'https://www.googleapis.com/auth/photoslibrary.readonly', // Google Photos API 스코프
    ],
  );

  @override
  void initState() {
    super.initState();
    // 이미 로그인된 사용자가 있는지 확인
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _fetchGooglePhotos();
      }
    });
    // 자동 로그인 ㅅ ㅣ도
    _googleSignIn.signInSilently();
  }

  Future<void> _fetchGooglePhotos() async {
    if (_currentUser == null) return;

    final authHeaders = await _currentUser!.authHeaders;
    final response = await http.get(
      Uri.parse('https://photoslibrary.googleapis.com/v1/mediaItems'),
      headers: {
        'Authorization': authHeaders['Authorization']!,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data); // Google Photos 목록 출력 (콘솔에서 확인 가능)
      setState(() {
        _photos = data['mediaItems'] ?? [];
      });
    } else {
      print('Failed to load photos: ${response.statusCode}');
    }
  }

  Future<void> _handleSignIn() async {
    try {
      // 사용자 로그인 시도
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.signOut(); // 사용자 로그아웃
    } catch (error) {
      print('Error signing out: $error');
    }
  }

  List<dynamic> _photos = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Photos API Demo'),
        actions: [
          if (_currentUser != null)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: _handleSignOut,
            )
        ],
      ),
      body: Center(
        child: _currentUser != null
            ? _buildPhotosList()
            : ElevatedButton(
                onPressed: _handleSignIn,
                child: Text('Sign in with Google'),
              ),
      ),
    );
  }

  Widget _buildPhotosList() {
    return ListView.builder(
      itemCount: _photos.length,
      itemBuilder: (context, index) {
        final photo = _photos[index];
        return ListTile(
          title: Text(photo['filename']),
          subtitle: Text(photo['mediaMetadata']['creationTime']),
          leading: Image.network(
            photo['baseUrl'] + '=w100-h100', // 썸네일 이미지
            fit: BoxFit.cover,
          ),
          onTap: () {
            // 이미지 또는 동영상을 선택했을 때 액션 추가 가능
          },
        );
      },
    );
  }

}
