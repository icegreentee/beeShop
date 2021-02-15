import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../LoginPage/index.dart';
import '../../routes/routeName.dart';
import '../../config/app_config.dart';
import '../../utils/tool/sp_util.dart';

/// 初始页。

var child = test();

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initAsync();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  _initAsync() async {
    //判断是否登录
    //未登录则转到登录状态
    //登录检测是否填写数据
    //未填写信息则进入引导页
    //全部完成进入主页
    String phoneNumber = await SpUtil.getData<String>("phoneNumber");
    String name = await SpUtil.getData<String>("name");
    String school = await SpUtil.getData<String>("school");
    String qq = await SpUtil.getData<String>("qq");
    String weixin = await SpUtil.getData<String>("weixin");
    String avatar = await SpUtil.getData<String>("avatar");
    print("phoneNumber:$phoneNumber");
    print("name:$name");
    print("school:$school");
    print("qq:$qq");
    print("weixin:$weixin");
    print("avatar:$avatar");
    setState(() {
      /// 是否显示引导页。
      // if (isNew) {
      //   SpUtil.setData("key_guide", false);
      //   child = WelcomePage();
      // } else {
      //   child = AdPage();
      // }
    });

    /// 调试阶段，直接跳过此组件
    // if (AppConfig.notSplash) {
    //   Navigator.pushReplacementNamed(context, RouteName.appMain);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: test(),
        onWillPop: () async => false,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class test extends StatefulWidget {
  test({Key key}) : super(key: key);

  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text("4444"),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return MyLoginPage();
          }));
        },
      ),
    );
  }
}

class test2 extends StatefulWidget {
  test2({Key key}) : super(key: key);

  @override
  _test2State createState() => _test2State();
}

class _test2State extends State<test2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("sss"),
    );
  }
}
