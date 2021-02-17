import 'package:beeShop/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../routes/routeName.dart';

/// 初始页。

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String phoneNumber;
  String name;
  @override
  void initState() {
    super.initState();
    _initAsync();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  _initAsync() async {
    String phoneNumber2 = await SpUtil.getData("phoneNumber");
    String name2 = await SpUtil.getData("name");
    setState(() {
      phoneNumber = phoneNumber2;
      name = name2;
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    print(phoneNumber);
    print(name);
    if (phoneNumber != null && phoneNumber.length > 0) {
      if (name != null && name.length > 0) {
        Future.delayed(Duration.zero, () {
          print("go to appMain");
          Navigator.of(context).pushReplacementNamed(RouteName.appMain);
        });
      } else {
        Future.delayed(Duration.zero, () {
          print("go to guidePage");
          Navigator.of(context).pushReplacementNamed(RouteName.guidePage);
        });
      }
    } else {
      Future.delayed(Duration.zero, () {
        print("go to loginPage");
        Navigator.of(context).pushReplacementNamed(RouteName.loginPage);
      });
    }

    return Scaffold(
      body: WillPopScope(
        child: Image.asset(
          "asset/images/login/splash_bg.png",
          height: double.infinity,
          fit: BoxFit.fitHeight,
        ),
        onWillPop: () async => false,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
