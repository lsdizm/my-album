import 'package:flutter/material.dart';
import '../pages/google_photo.dart';
import '../pages/ftp_server.dart';
import '../pages/setting.dart';

class Menu extends StatelessWidget {
  final Function(Widget, String) onSelectScreen;

  const Menu({super.key, required this.onSelectScreen});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey[900], // Drawer 헤더 배경색
            ),
            child: const Text('My Album Menu', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera_back),
            title: const Text('Google Photos'),
            onTap: () => onSelectScreen(const GooglePhoto(), "Google Photo")
          ),
          ListTile(
            leading: const Icon(Icons.snippet_folder),
            title: const Text('FTP Server'),
            onTap: () => onSelectScreen(const FtpServer(), "FTP Server")            
          ),
          ListTile(
            leading: const Icon(Icons.usb),
            title: const Text('USB Folder'),
            onTap: () => onSelectScreen(const FtpServer(), "USB Folder")
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => onSelectScreen(const Setting(), "Setting")
          ),
        ],
      ),
    );
  }

}
