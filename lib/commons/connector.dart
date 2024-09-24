import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_information.dart';

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
