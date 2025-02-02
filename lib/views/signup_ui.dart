// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:iot_sau_pm_project/models/user.dart';
import 'package:iot_sau_pm_project/services/call_user_api.dart';

class SignupUI extends StatefulWidget {
  const SignupUI({super.key});

  @override
  State<SignupUI> createState() => _SignupUIState();
}

class _SignupUIState extends State<SignupUI> {
  //สร้างตัวแปรสำหรับเปิดปิดรหัสผ่าน
  bool pwdVisible = true;

  //สร้าง instance/object เพื่อควบคุมตัว TextField
  TextEditingController userFullnameCtrl = TextEditingController();
  TextEditingController userEmailCtrl = TextEditingController();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPasswordCtrl = TextEditingController();

  //สร้างเมธอดแสดงข้อความเตือน
  void showWarningMSG(context, msg) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'คำเตือน',
          textAlign: TextAlign.center,
        ),
        content: Text(
          msg,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'ตกลง',
            ),
          ),
        ],
      ),
    );
  }

  //สร้างเมธอดแสดงข้อความสำเร็จ
  Future showCompleteMSG(context, msg) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'ผลการทำงาน',
          textAlign: TextAlign.center,
        ),
        content: Text(
          msg,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'ตกลง',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          'Signup PM APP',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 30.0,
            right: 30.0,
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.35,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ชื่อ-นามสกุล',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextField(
                  controller: userFullnameCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'fullname',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    prefixIcon: Icon(
                      Icons.list_alt,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'อีเมล์',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextField(
                  controller: userEmailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'email',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    prefixIcon: Icon(
                      Icons.mail,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ชื่อผู้ใช้',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextField(
                  controller: userNameCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'username',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'รหัสผ่าน',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextField(
                  controller: userPasswordCtrl,
                  obscureText: pwdVisible,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          pwdVisible = !pwdVisible;
                        });
                      },
                      icon: Icon(
                        pwdVisible == true ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                ElevatedButton(
                  onPressed: () {
                    //Validate UI
                    if (userFullnameCtrl.text.isEmpty) {
                      showWarningMSG(context, 'กรุณากรอกชื่อ-นามสกุล');
                    } else if (userEmailCtrl.text.isEmpty) {
                      showWarningMSG(context, 'กรุณากรอกอีเมล์');
                    } else if (userNameCtrl.text.isEmpty) {
                      showWarningMSG(context, 'กรุณากรอกชื่อผู้ใช้');
                    } else if (userPasswordCtrl.text.isEmpty) {
                      showWarningMSG(context, 'กรุณากรอกรหัสผ่าน');
                    } else {
                      //เรียกเมธอดเพื่อเรียกใช้ API เพื่อบันทึกข้อมูล user ลงตาราง user_tb
                      //แพ็คข้อมูลที่จะส่งไปกับการเรียกใช้ API
                      User user = User(
                        userFullname: userFullnameCtrl.text,
                        userEmail: userEmailCtrl.text,
                        userName: userNameCtrl.text,
                        userPassword: userPasswordCtrl.text,
                      );
                      //เรียกเมธอดเพื่อเรียกใช้ API
                      CallUserAPI.insertUserAPI(user).then((value) {
                        if (value[0].message == "1") {
                          //แสดงข้อความ Signup สําเร็จ
                          showCompleteMSG(context, "ลงทะเบียนสำเร็จ").then((value) {
                            Navigator.pop(context);
                          });
                        } else {
                          //แสดงข้อความ Signup ไม่สําเร็จ
                          showWarningMSG(context, "ลงทะเบียนไม่สำเร็จ");
                        }
                      });
                    }
                  },
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height * 0.055,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
