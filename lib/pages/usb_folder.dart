import 'package:flutter/material.dart';

class UsbFolder extends StatefulWidget {
  const UsbFolder({super.key});

  @override
  _UsbFolderState createState() => _UsbFolderState();
}

class _UsbFolderState extends State<UsbFolder> {
    @override
  void initState() {
    super.initState();
  }
  
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
