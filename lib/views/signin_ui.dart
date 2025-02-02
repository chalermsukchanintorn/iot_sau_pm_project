// ignore_for_file: sort_child_properties_last, prefer_is_empty, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iot_sau_pm_project/models/user.dart';
import 'package:iot_sau_pm_project/services/call_user_api.dart';
import 'package:iot_sau_pm_project/views/home_ui.dart';
import 'package:iot_sau_pm_project/views/signup_ui.dart';

class SigninUI extends StatefulWidget {
  const SigninUI({super.key});

  @override
  State<SigninUI> createState() => _SigninUIState();
}

class _SigninUIState extends State<SigninUI> {
  //สร้างตัวแปรสำหรับเปิดปิดรหัสผ่าน
  bool pwdVisible = true;

  //สร้าง instance/object เพื่อควบคุมตัว TextField
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          'Signin PM APP',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
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
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
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
                  height: MediaQuery.of(context).size.height * 0.02,
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
                        //โค้ดที่มีผลต่อการแสดงผลให้เขียนอยู่ภายใน setState
                        setState(() {
                          pwdVisible = !pwdVisible;
                        });
                      },
                      icon: Icon(
                        //Ternary opt. _____ ? _____ : ______
                        pwdVisible == true ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'ลืมรหัสผ่าน',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                ElevatedButton(
                  onPressed: () {
                    //Validate UI
                    if (userNameCtrl.text.trim().length == 0) {
                      showWarningMSG(context, 'ป้อนชื่อผู้ใช้ด้วย');
                    } else if (userPasswordCtrl.text.trim().length == 0) {
                      showWarningMSG(context, 'ป้อนรหัสผ่านด้วย');
                    } else {
                      //เอาชื่อผู้ใช้รหัสผ่านไปตรวจสอบ
                      //เรียกเมธอดเพื่อเรียกใช้ API ตรวจสอบข้อมูล user จาก user_tb
                      //แพ็คข้อมูลที่จะส่งไปกับการเรียกใช้ API
                      User user = User(
                        userName: userNameCtrl.text,
                        userPassword: userPasswordCtrl.text,
                      );
                      //เรียกเมธอดเพื่อเรียกใช้ API
                      CallUserAPI.checkUserAPI(user).then((value) {
                        if (value[0].message == "1") {
                          //ชื่อผู้ใช้รหัสผ่านถูกต้อง เปิดไปหน้า HomeUI()
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeUI(),
                            ),
                          );
                        } else {
                          //ชื่อผู้ใช้รหัสผ่านไม่ถูกต้อง
                          showWarningMSG(context, "ชื่อผู้ใช้ รหัสผ่านไม่ถูกต้อง");
                        }
                      });
                    }
                  },
                  child: Text(
                    'Signin',
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
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ยังไม่มีบัญชี?',
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupUI(),
                          ),
                        );
                      },
                      child: Text(
                        'ลงทะเบียน',
                        style: TextStyle(
                          color: Colors.red[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
