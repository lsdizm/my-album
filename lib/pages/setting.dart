import 'package:flutter/material.dart';
import '../commons/connector.dart';
import '../models/user_information.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab 3'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Center(child: Text('Dashboard Tab 1')),
            Center(child: _buildUserInfo()), // 유저 정보 표시
            const Center(child: Text('Dashboard Tab 3')),
          ],
        ),
      ),
    );
  }

  // 유저 정보를 보여주는 부분
  Widget _buildUserInfo() {
    return FutureBuilder<UserInformation>(
      future: getUser(), // getUser 함수 호출
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // 로딩 중
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // 에러 발생 시
        } else if (snapshot.hasData) {
          UserInformation? user = snapshot.data;
          return Text(
              'User ID: ${user?.id}\nTitle: ${user?.title}\nCompleted: ${user?.completed}');
        } else {
          return const Text('No data'); // 데이터가 없을 경우
        }
      },
    );
  }
}
