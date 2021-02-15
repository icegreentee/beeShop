import 'package:flutter/material.dart';

import 'app_env.dart' show appEnv;
import '../routes/routeName.dart';

class AppConfig {
  /// 设计稿尺寸 宽750 高1334
  static Size screenSize = Size(750, 1334);

  /// 是否开启dio接口详细信息输出，以及其它相关插件调试信息
  static const DEBUG = true;

  /// 是否开启LogUtil类打印方法
  static const printFlag = true;

  /// dio请求前缀
  static String host = appEnv.baseUrl;

  /// 是否启用代理，启用代理后，反向代理IP及端口才能生效
  static const usingProxy = false;

  /// 反向代理的IP/域名地址
  static const proxyAddress = '192.168.2.201:9003';
}
