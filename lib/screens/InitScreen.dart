import 'package:flutter/material.dart';
import 'package:pikapi/basic/Themes.dart';
import 'package:pikapi/basic/Pica.dart';

import 'AccountScreen.dart';
import 'AppScreen.dart';

// 初始化界面
class InitScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  initState() {
    _init();
    super.initState();
  }

  Future<dynamic> _init() async {
    // 从数据库读取并切换主题
    changeThemeByCode(await pica.loadTheme());
    // 登录, 如果token失效重新登录, 网络不好的时候可能需要1分钟
    if (await pica.preLogin()) {
      // 如果token或username+password有效则直接进入登录好的界面
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppScreen()),
      );
    } else {
      // 否则跳转到登录页
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AccountScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffced),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: new Image.asset(
          "lib/assets/init.jpg",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
