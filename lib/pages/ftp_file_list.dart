import 'package:flutter/material.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FtpFileListPage extends StatefulWidget {
  @override
  _FtpFileListPageState createState() => _FtpFileListPageState();
}

class _FtpFileListPageState extends State<FtpFileListPage> {
  List<String> files = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFtpFiles();
  }

  Future<void> _fetchFtpFiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ftpUrl = prefs.getString('ftp_url') ?? '';
    String username = prefs.getString('ftp_username') ?? '';
    String password = prefs.getString('ftp_password') ?? '';

    if (ftpUrl.isEmpty || username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('FTP 설정이 필요합니다.')),
      );
      setState(() => isLoading = false);
      return;
    }

    FTPConnect ftpConnect = FTPConnect(
      ftpUrl,
      user: username,
      pass: password,
    );

    try {
      await ftpConnect.connect();
      //await ftpConnect.setPassive();
      List<FTPEntry> list = await ftpConnect.listDirectoryContent();
      await ftpConnect.disconnect();

      setState(() {
        files = list.map((file) => file.name).toList();
        isLoading = false;
      });
    } catch (e) {
      print("FTP 연결 오류: $e");
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('FTP 연결 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FTP 파일 목록')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : files.isEmpty
              ? Center(child: Text('파일이 없습니다.'))
              : ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(files[index]),
                      onTap: () {
                        // TODO: 동영상 재생 화면으로 이동
                      },
                    );
                  },
                ),
    );
  }
}
