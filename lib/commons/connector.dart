import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/menu_item.dart';
import '../models/user_information.dart';
import '../pages/google_photo.dart';
import '../pages/ftp_server.dart';
import '../pages/usb_folder.dart';
import '../pages/setting.dart';

// 사용자 정보 조회
Future<UserInformation> getUser() async {
  var url = "https://jsonplaceholder.typicode.com/todos/1";
  var response = await http.get(Uri.parse(url), headers: {"test": "test"});

  if (response.statusCode == 200) {  
    var result = json.decode(response.body);
    var user = UserInformation.fromJson(result);
    return user;
  } else {    
    throw Exception('Failed to load user');
  }
}
