import 'dart:io';

import 'package:beeShop/models/userJson.dart';
import 'package:beeShop/routes/routeName.dart';
import 'package:beeShop/utils/index.dart';
import 'package:beeShop/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:jverify/jverify.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: WillPopScope(
        child: Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 60),
            child: Form(
                child: Column(
              children: [
                Center(
                  child: Image.asset("asset/images/login/ic_beeshop.png"),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "请输入手机号",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow)),
                      // contentPadding: EdgeInsets.only(top: 10, bottom: 0),
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(
                        color: Color(0xff999999),
                        fontSize: 13,
                      )),
                  onChanged: (newValue) {
                    phoneNumber = newValue;
                  },
                  // validator: validatoruser,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "请输入验证码",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow)),
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(
                        color: Color(0xff999999),
                        fontSize: 13,
                      ),
                      suffixIcon: Container(
                        height: 10,
                        child: TextButton(
                          onPressed: () {
                            Tips.info("验证码已发送");
                          },
                          child: Text(
                            "发送验证码",
                            style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )),
                  onSaved: (newValue) {
                    // password = newValue;
                  },
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text("登录"),
                    color: Colors.yellow,
                    elevation: 0.0,
                    shape: StadiumBorder(side: BorderSide.none),
                    onPressed: () async {
                      Map res = await Request.post('/login/sign', data: {
                        'phoneNumber': phoneNumber,
                      }).catchError((e) {
                        Tips.info("后端获取手机号失败");
                      });
                      Tips.info("登陆成功");
                      var user = new UserJson.fromJson(res);
                      await SpUtil.setData(
                          "phoneNumber", user.data.phoneNumber);
                      await SpUtil.setData("name", user.data.name);
                      await SpUtil.setData("school", user.data.school);
                      await SpUtil.setData("qq", user.data.qq);
                      await SpUtil.setData("weixin", user.data.weixin);
                      await SpUtil.setData("avatar", user.data.avatar);
                      if (user.data.name.length > 0) {
                        Navigator.of(context)
                            .pushReplacementNamed(RouteName.appMain);
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed(RouteName.guidePage);
                      }
                    },
                  ),
                ),
                Center(
                  child: TextButton(
                    child: Text("一键登录"),
                    onPressed: () {
                      loginAuth();
                    },
                  ),
                )
              ],
            ))),
        onWillPop: () async => false,
      ),
      resizeToAvoidBottomInset: false,
    ));
  }

  final Jverify jverify = new Jverify();

  void loginAuth() {
    jverify.setup(
        appKey: "62c8cc14fcbe9b7c92965e41", //"你自己应用的 AppKey",
        channel: "devloper-default");
    jverify.checkVerifyEnable().then((map) {
      bool result = map["result"];
      if (result) {
        var uiConfig = setConfig();

        /// 步骤 1：调用接口设置 UI
        jverify.setCustomAuthorizationView(true, uiConfig,
            landscapeConfig: uiConfig);

        jverify.loginAuth(true).then((map) async {
          /// 在回调里获取 loginAuth 接口异步返回数据（如果是通过添加 JVLoginAuthCallBackListener 监听来获取返回数据，则忽略此步骤）
          print("-------认证--------");
          print(map);
          int code = map["code"];
          String content = map["message"];
          String operator = map["operator"];
          print("falgtest，code=$code,message = $content,operator = $operator");
          if (code == 6000) {
            Map res = await Request.post(
              '/login/singlesign',
              data: {'loginToken': content},
            ).catchError((e) {
              Tips.info("后端获取手机号失败");
            });
            print(res);
            var user = new UserJson.fromJson(res);
            if (user.code == 2000) {
              await SpUtil.setData("phoneNumber", user.data.phoneNumber);
              await SpUtil.setData("name", user.data.name);
              await SpUtil.setData("school", user.data.school);
              await SpUtil.setData("qq", user.data.qq);
              await SpUtil.setData("weixin", user.data.weixin);
              await SpUtil.setData("avatar", user.data.avatar);
              Tips.info("登录成功");
              if (user.data.name.length > 0) {
                Navigator.of(context).pushReplacementNamed(RouteName.appMain);
              } else {
                Navigator.of(context).pushReplacementNamed(RouteName.guidePage);
              }
            } else {
              Tips.info(user.msg);
            }
          }
        });
      } else {
        Tips.info("认证失败");
      }
    });
  }

  JVUIConfig setConfig() {
    bool isiOS = Platform.isIOS;
    JVUIConfig uiConfig = JVUIConfig();
    uiConfig.navReturnBtnHidden = false;
    uiConfig.navText = "一键登录";
    // uiConfig.navColor = Colors.white.value;

    uiConfig.logoWidth = 250;
    uiConfig.logoHeight = 80;
    uiConfig.logoOffsetY = 30;
    uiConfig.logoVerticalLayoutItem = JVIOSLayoutItem.ItemSuper;
    uiConfig.logoHidden = false;
    uiConfig.logoImgPath = "login_logo";

    uiConfig.numberFieldWidth = 200;
    uiConfig.numberFieldHeight = 40;
    uiConfig.numFieldOffsetY = isiOS ? 20 : 120;
    uiConfig.numberVerticalLayoutItem = JVIOSLayoutItem.ItemLogo;
    uiConfig.numberColor = Colors.black.value;
    uiConfig.numberSize = 18;

    uiConfig.sloganOffsetY = isiOS ? 20 : 160;
    uiConfig.sloganVerticalLayoutItem = JVIOSLayoutItem.ItemNumber;
    uiConfig.sloganTextColor = Colors.black.value;
    uiConfig.sloganTextSize = 15;

    uiConfig.logBtnWidth = 300;
    uiConfig.logBtnHeight = 50;
    uiConfig.logBtnOffsetY = isiOS ? 20 : 230;
    uiConfig.logBtnVerticalLayoutItem = JVIOSLayoutItem.ItemSlogan;
    uiConfig.logBtnText = "本机号码一键登录";
    uiConfig.logBtnTextColor = Colors.white.value;
    uiConfig.logBtnTextSize = 16;
    uiConfig.loginBtnNormalImage = "login_btn_normal"; //图片必须存在
    uiConfig.loginBtnPressedImage = "login_btn_press"; //图片必须存在
    uiConfig.loginBtnUnableImage = "login_btn_unable"; //图片必须存在
    uiConfig.privacyState = true;
    uiConfig.privacyCheckboxHidden = true;

    uiConfig.privacyOffsetY = 15; // 距离底部距离
    uiConfig.privacyVerticalLayoutItem = JVIOSLayoutItem.ItemSuper;
    uiConfig.clauseBaseColor = Colors.black.value;
    uiConfig.clauseColor = Colors.blue[600].value;
    uiConfig.privacyText = ["登录即同意"];
    uiConfig.privacyTextSize = 12;

    uiConfig.statusBarColorWithNav = true;
    uiConfig.virtualButtonTransparent = true;

    uiConfig.privacyStatusBarColorWithNav = true;
    uiConfig.privacyVirtualButtonTransparent = true;

    uiConfig.needStartAnim = true;
    uiConfig.needCloseAnim = true;

    uiConfig.privacyNavColor = Colors.blue.value;
    uiConfig.privacyNavTitleTextColor = Colors.white.value;
    uiConfig.privacyNavTitleTextSize = 16;
    return uiConfig;
  }
}
