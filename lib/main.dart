import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'web.dart';

void main() {
  runApp(AutoAttendApp());
}

class AutoAttendApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '그룹웨어 자동 출퇴근',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String id = "";
  String pw = "";

  @override
  void initState() {
    super.initState();
    // final prefs = await SharedPreferences.getInstance();
    // id = prefs.getString("id") ?? "";
    // pw = prefs.getString("pw") ?? "";
    // if (id != "" && pw != "") {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => WebPageApp(id, pw)));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/uni.png',
                  width: 100,
                ),
                SizedBox(height: 16.0),
                Text('자동 출퇴근 처리'),
              ],
            ),
            SizedBox(height: 80.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text('저장하기'),
                  onPressed: () {
                    String name;
                    String password;
                    if(_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                      name = _usernameController.text;
                      password = _passwordController.text;
                      // TODO 현재는 입력한 ID와 비밀번호를 넘겨준다.
                      Navigator.push(context, MaterialPageRoute(builder: (context) => WebPageApp(name, password)));
                    } else {
                      name = ""; password = "";
                      Fluttertoast.showToast(msg: "아이디랑 비밀번호 둘다 입력 필요");
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
