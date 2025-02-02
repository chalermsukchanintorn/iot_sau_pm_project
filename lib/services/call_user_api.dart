// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:iot_sau_pm_project/config/env.dart';
import 'package:iot_sau_pm_project/models/user.dart';
import 'package:http/http.dart' as http;

class CallUserAPI {
  //สร้างเมธอดเรียก API ที่ทำงานกับตาราง user_tb
  //สร้างเมธอดเรียก API : insert_user_api.php -------------------------
  static Future<List<User>> insertUserAPI(User user) async {
    //ส่วนของการเรียกใช้ API ให้ทำงาน
    final responseData = await http.post(
      Uri.parse(Env.mainUrl + '/insert_user_api.php'),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    //นำผลที่ได้จากการเรียกใช้ API ไปใช้งาน
    if (responseData.statusCode == 201) {
      //แปลงข้อมูลที่ได้จาก API ซึ่งเป็น JSON ให้เป็นข้อมูลแบบ List<User> เพื่อใช้งานต่อไป
      final responseDataDecode = jsonDecode(responseData.body);
      final List<User> data = await responseDataDecode.map<User>((e) => User.fromJson(e)).toList();
      return data;
    } else {
      throw Exception('Failed to insert user' + responseData.toString());
    }
  }
  //-----------------------------------------------------------------

  //สร้างเมธอดเรียก API : check_user_api.php ---------------------------
  static Future<List<User>> checkUserAPI(User user) async {
    //ส่วนของการเรียกใช้ API ให้ทำงาน
    final responseData = await http.get(
      Uri.parse(Env.mainUrl + '/check_user_api.php?userName=${user.userName}&userPassword=${user.userPassword}'),
      headers: {'Content-Type': 'application/json'},
    );

    //นำผลที่ได้จากการเรียกใช้ API ไปใช้งาน
    if (responseData.statusCode == 200 || responseData.statusCode == 404) {
      //แปลงข้อมูลที่ได้จาก API ซึ่งเป็น JSON ให้เป็นข้อมูลแบบ List<User> เพื่อใช้งานต่อไป
      final responseDataDecode = jsonDecode(responseData.body);
      final List<User> data = await responseDataDecode.map<User>((e) => User.fromJson(e)).toList();
      return data;
    } else {
      throw Exception('Failed to check user' + responseData.toString());
    }
  }
  //-----------------------------------------------------------------
}
