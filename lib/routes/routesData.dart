import 'package:flutter/material.dart';
import 'routeName.dart';
import '../pages/ErrorPage/ErrorPage.dart';
import '../pages/AppMain/AppMain.dart';
import '../pages/SplashPage/SplashPage.dart';
import '../pages/LoginPage/LoginPage.dart';
import '../pages/GuidePage/GuidePage.dart';

final String initialRoute = RouteName.splashPage; // 初始默认显示的路由
final Map<String, WidgetBuilder> routesData = {
  // 页面路由定义...
  RouteName.appMain: (context, {params}) => AppMain(params: params),
  RouteName.splashPage: (context, {params}) => SplashPage(),
  RouteName.loginPage: (context, {params}) => LoginPage(),
  RouteName.guidePage: (context, {params}) => GuidePage(),
  RouteName.error: (context, {params}) => ErrorPage(params: params),
};
