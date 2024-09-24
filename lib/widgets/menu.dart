import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../commons/connector.dart';
import '../models/menu_item.dart';
import '../pages/google_photo.dart';
import '../pages/home.dart';
import '../pages/ftp_server.dart';
import '../pages/usb_folder.dart';
import '../pages/setting.dart';

class Menu extends StatelessWidget {
  final Function(Widget, String) onSelectScreen;

  Menu({super.key, required this.onSelectScreen});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('My Album Menu', style: TextStyle(color: Colors.white)), // 글자 흰색
            decoration: BoxDecoration(
              color: Colors.blueGrey[900], // Drawer 헤더 배경색
            ),
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera_back),
            title: const Text('Google Photos'),
            onTap: () => onSelectScreen(GooglePhoto(), "Google Photo")
          ),
          ListTile(
            leading: const Icon(Icons.snippet_folder),
            title: const Text('FTP Server'),
            onTap: () => onSelectScreen(FtpServer(), "FTP Server")            
          ),
          ListTile(
            leading: const Icon(Icons.usb),
            title: const Text('USB Folder'),
            onTap: () => onSelectScreen(FtpServer(), "USB Folder")
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => onSelectScreen(Setting(), "Setting")
          ),
        ],
      ),
    );
  }

}