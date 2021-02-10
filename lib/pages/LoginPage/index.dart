import 'dart:io';

import 'package:flutter/material.dart';
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
    // setState(() {
    //   _loading = true;
    // });
    jverify.checkVerifyEnable().then((map) {
      bool result = map["result"];
      if (result) {
        final screenSize = MediaQuery.of(context).size;
        final screenWidth = screenSize.width;
        final screenHeight = screenSize.height;
        bool isiOS = Platform.isIOS;

        /// 自定义授权的 UI 界面，以下设置的图片必须添加到资源文件里，
        /// android项目将图片存放至drawable文件夹下，可使用图片选择器的文件名,例如：btn_login.xml,入参为"btn_login"。
        /// ios项目存放在 Assets.xcassets。
        ///
        JVUIConfig uiConfig = JVUIConfig();
        //uiConfig.authBackgroundImage = ;

        // uiConfig.navHidden = false;
        uiConfig.navReturnBtnHidden = true;
        uiConfig.navColor = Colors.white.value;
        // uiConfig.navText = "登录";
        // uiConfig.navTextColor = Colors.blue.value;
        // uiConfig.navReturnImgPath = "return_bg"; //图片必须存在

        uiConfig.logoWidth = 250;
        uiConfig.logoHeight = 80;
        //uiConfig.logoOffsetX = isiOS ? 0 : null;//(screenWidth/2 - uiConfig.logoWidth/2).toInt();
        uiConfig.logoOffsetY = 30;
        uiConfig.logoVerticalLayoutItem = JVIOSLayoutItem.ItemSuper;
        uiConfig.logoHidden = false;
        uiConfig.logoImgPath = "login_logo";

        uiConfig.numberFieldWidth = 200;
        uiConfig.numberFieldHeight = 40;
        //uiConfig.numFieldOffsetX = isiOS ? 0 : null;//(screenWidth/2 - uiConfig.numberFieldWidth/2).toInt();
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
        //uiConfig.logBtnOffsetX = isiOS ? 0 : null;//(screenWidth/2 - uiConfig.logBtnWidth/2).toInt();
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

        //uiConfig.privacyOffsetX = isiOS ? (20 + uiConfig.privacyCheckboxSize) : null;
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
        //buttonWidget.btnNormalImageName = "";
        //buttonWidget.btnPressedImageName = "";
        //buttonWidget.textAlignment = JVTextAlignmentType.left;

        // 添加点击事件监听
        jverify.addClikWidgetEventListener(btn_widgetId, (eventId) {
          if (btn_widgetId == eventId) {
            print("receive listener - 点击【新加 button】");
          }
        });
        widgetList.add(buttonWidget);

        /// 步骤 1：调用接口设置 UI
        jverify.setCustomAuthorizationView(true, uiConfig,
            landscapeConfig: uiConfig, widgets: widgetList);

        jverify.loginAuth(true).then((map) {
          /// 再，在回调里获取 loginAuth 接口异步返回数据（如果是通过添加 JVLoginAuthCallBackListener 监听来获取返回数据，则忽略此步骤）
          int code = map["code"];
          String content = map["message"];
          String operator = map["operator"];
          // setState(() {
          //   _loading = false;
          //   _result = "接口异步返回数据：[$code] message = $content";
          // });
          print(
              "通过接口异步返回，获取到 loginAuth 接口返回数据，code=$code,message = $content,operator = $operator");
        });
      } else {
        // setState(() {
        //   _loading = false;
        //   _result = "[2016],msg = 当前网络环境不支持认证";
        // });

        /*
        final String text_widgetId = "jv_add_custom_text";// 标识控件 id
        JVCustomWidget textWidget = JVCustomWidget(text_widgetId, JVCustomWidgetType.textView);
        textWidget.title = "新加 text view 控件";
        textWidget.left = 20;
        textWidget.top = 360 ;
        textWidget.width = 200;
        textWidget.height  = 40;
        textWidget.backgroundColor = Colors.yellow.value;
        textWidget.isShowUnderline = true;
        textWidget.textAlignment = JVTextAlignmentType.center;
        textWidget.isClickEnable = true;

        // 添加点击事件监听
        jverify.addClikWidgetEventListener(text_widgetId, (eventId) {
          print("receive listener - click widget event :$eventId");
          if (text_widgetId == eventId) {
            print("receive listener - 点击【新加 text】");
          }
        });
        widgetList.add(textWidget);

        final String btn_widgetId = "jv_add_custom_button";// 标识控件 id
        JVCustomWidget buttonWidget = JVCustomWidget(btn_widgetId, JVCustomWidgetType.button);
        buttonWidget.title = "新加 button 控件";
        buttonWidget.left = 100;
        buttonWidget.top = 400;
        buttonWidget.width = 150;
        buttonWidget.height  = 40;
        buttonWidget.isShowUnderline = true;
        buttonWidget.backgroundColor = Colors.brown.value;
        //buttonWidget.btnNormalImageName = "";
        //buttonWidget.btnPressedImageName = "";
        //buttonWidget.textAlignment = JVTextAlignmentType.left;

        // 添加点击事件监听
        jverify.addClikWidgetEventListener(btn_widgetId, (eventId) {
          print("receive listener - click widget event :$eventId");
          if (btn_widgetId == eventId) {
            print("receive listener - 点击【新加 button】");
          }
        });
        widgetList.add(buttonWidget);
        */

        /* 弹框模式
        JVPopViewConfig popViewConfig = JVPopViewConfig();
        popViewConfig.width = (screenWidth - 100.0).toInt();
        popViewConfig.height = (screenHeight - 150.0).toInt();

        uiConfig.popViewConfig = popViewConfig;
        */

        /*

        /// 方式二：使用异步接口 （如果想使用异步接口，则忽略此步骤，看方式二）

        /// 先，执行异步的一键登录接口
        

        */

      }
    });
  }
}
