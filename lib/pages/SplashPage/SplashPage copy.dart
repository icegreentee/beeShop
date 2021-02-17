import 'package:beeShop/pages/SplashPage/components/GuidePage.dart';
import 'package:beeShop/pages/SplashPage/components/LoginPage.dart';
import 'package:beeShop/pages/SplashPage/provider/splashStore.p.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import '../LoginPage/index.dart';
import '../../routes/routeName.dart';
import '../../config/app_config.dart';
import '../../utils/tool/sp_util.dart';

/// 初始页。

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  List<Widget> widgetList = [LoginPage(), GuidePage()];
  SplashStore splashStore;
  @override
  void initState() {
    super.initState();
    // _initAsync();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  // _initAsync() async {
  //   //判断是否登录
  //   //未登录则转到登录状态
  //   //登录检测是否填写数据
  //   //未填写信息则进入引导页
  //   //全部完成进入主页
  //   String phoneNumber = await SpUtil.getData<String>("phoneNumber");
  //   String name = await SpUtil.getData<String>("name");
  //   String school = await SpUtil.getData<String>("school");
  //   String qq = await SpUtil.getData<String>("qq");
  //   String weixin = await SpUtil.getData<String>("weixin");
  //   String avatar = await SpUtil.getData<String>("avatar");
  //   print("phoneNumber:$phoneNumber");
  //   print("name:$name");
  //   print("school:$school");
  //   print("qq:$qq");
  //   print("weixin:$weixin");
  //   print("avatar:$avatar");
  //   setState(() {
  //     /// 是否显示引导页。
  //     // if (isNew) {
  //     //   SpUtil.setData("key_guide", false);
  //     //   child = WelcomePage();
  //     // } else {
  //     //   child = AdPage();
  //     // }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    splashStore = Provider.of<SplashStore>(context);
    return Scaffold(
      body: WillPopScope(
        child: Consumer<SplashStore>(
          builder: (_, splashStore, child) {
            return widgetList[splashStore.index];
          },
        ),
        onWillPop: () async => false,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
