import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:beeShop/utils/index.dart';
import 'package:beeShop/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jverify/jverify.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      allowFontScaling: true,
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Jverify jverify = new Jverify();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          loginAuth();
        },
        child: Text("一键登录"),
      ),
    );
  }

  Future<void> initLogin() async {
    jverify.setup(
        appKey: "62c8cc14fcbe9b7c92965e41", //"你自己应用的 AppKey",
        channel: "devloper-default");
    // loginAuth();
  }

  /// SDK 请求授权一键登录
  void loginAuth() {
    jverify.checkVerifyEnable().then((map) {
      bool result = map["result"];
      if (result) {
        var uiConfig = setConfig();
        var widgetList = getWidgetList();

        /// 步骤 1：调用接口设置 UI
        jverify.setCustomAuthorizationView(true, uiConfig,
            landscapeConfig: uiConfig, widgets: widgetList);

        print("ok");
        jverify.loginAuth(false).then((map) async {
          /// 在回调里获取 loginAuth 接口异步返回数据（如果是通过添加 JVLoginAuthCallBackListener 监听来获取返回数据，则忽略此步骤）
          print("-------认证--------");
          print(map);
          int code = map["code"];
          String content = map["message"];
          String operator = map["operator"];
          print("falgtest，code=$code,message = $content,operator = $operator");
          // Map res = await Request.post(
          //   '/login/singlesign',
          //   data: {'token': content},
          // ).catchError((e) {
          //   Tips.info("后端获取手机号失败");
          // });
          // Tips.info("登陆成功");
          // print(res);
        });
      } else {
        Tips.info("认证失败");
      }
    });
  }

  JVUIConfig setConfig() {
    bool isiOS = Platform.isIOS;
    JVUIConfig uiConfig = JVUIConfig();
    uiConfig.navReturnBtnHidden = true;
    uiConfig.navColor = Colors.white.value;

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

  List<JVCustomWidget> getWidgetList() {
    /// 添加自定义的 控件 到授权界面
    List<JVCustomWidget> widgetList = [];

    final String btn_widgetId = "jv_add_custom_button"; // 标识控件 id
    JVCustomWidget buttonWidget =
        JVCustomWidget(btn_widgetId, JVCustomWidgetType.button);
    buttonWidget.title = "手机号码登录";
    buttonWidget.left = 100;
    buttonWidget.top = 300;
    buttonWidget.width = 150;
    buttonWidget.height = 40;
    buttonWidget.isShowUnderline = false;
    buttonWidget.backgroundColor = Colors.brown.value;

    // 添加点击事件监听
    jverify.addClikWidgetEventListener(btn_widgetId, (eventId) {
      if (btn_widgetId == eventId) {
        print("receive listener - 点击【新加 button】");
        jverify.dismissLoginAuthView();
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return otherLogin();
        }));
      }
    });
    widgetList.add(buttonWidget);
    return widgetList;
  }
}

class otherLogin extends StatefulWidget {
  @override
  _otherLoginState createState() => _otherLoginState();
}

class _otherLoginState extends State<otherLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginContent(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: "back",
          color: Colors.black,
          onPressed: () {
            print("back to login");
          },
        ),
      ),
    );
  }
}

class LoginContent extends StatefulWidget {
  LoginContent({Key key}) : super(key: key);

  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: "请输入手机号",
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)),
                  contentPadding: EdgeInsets.only(top: 10, bottom: 0),
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 13,
                  )),
              onSaved: (newValue) {
                // username = newValue;
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
                onPressed: () {},
              ),
            )
          ],
        )));
  }
}
