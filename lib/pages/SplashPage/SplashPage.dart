import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../LoginPage/index.dart';
import '../../routes/routeName.dart';
import '../../config/app_config.dart';
import '../../utils/tool/sp_util.dart';

/// 闪屏页。
class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Widget child;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    _initAsync();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  _initAsync() async {
    //判断是否登录
    //未登录则转到登录状态
    //登录检测是否填写数据
    //未填写信息则进入引导页
    //全部完成进入主页

    // var isNew = await SpUtil.getData<bool>("key_guide", defValue: true);
    setState(() {
      child = MyLoginPage();

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
        child: child,
        onWillPop: () async => false,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
