import 'dart:convert';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import '../config/app_config.dart';
import 'dio/interceptors/header_interceptor.dart';
import 'dio/interceptors/log_interceptor.dart';
import '../config/app_env.dart';

Dio _initDio() {
  BaseOptions baseOpts = new BaseOptions(
    connectTimeout: 50000, // 连接服务器超时时间，单位是毫秒
    responseType: ResponseType.plain, // 数据类型
    receiveDataWhenStatusError: true,
  );
  Dio dioClient = new Dio(baseOpts); // 实例化请求，可以传入options参数
  dioClient.interceptors.addAll([
    HeaderInterceptors(),
    LogsInterceptors(),
  ]);
  return dioClient;
}

/// 底层请求方法说明
///
/// [options] dio请求的配置参数，默认get请求
///
/// [data] 请求参数
///
/// [cancelToken] 请求取消对象
///
///```dart
///CancelToken token = CancelToken(); // 通过CancelToken来取消发起的请求
///
///safeRequest(
///  "/test",
///  data: {"id": 12, "name": "xx"},
///  options: Options(method: "POST"),
/// cancelToken: token,
///);
///
///// 取消请求
///token.cancel("cancelled");
///```
Future safeRequest(
  String url, {
  Object data,
  Options options,
  Map<String, dynamic> queryParameters,
  CancelToken cancelToken,
}) async {
  try {
    if (AppConfig.usingProxy) {
      final adapter =
          Request.dioClient.httpClientAdapter as DefaultHttpClientAdapter;
      adapter.onHttpClientCreate = (client) {
        // 设置Http代理
        client.findProxy = (uri) {
          return "PROXY ${AppConfig.proxyAddress}";
        };
        // https证书校验
        client.badCertificateCallback = (cert, host, port) => true;
      };
    }

    return Request.dioClient
        .request(
          appEnv.baseUrl + url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        )
        .then((data) => jsonDecode(data.data));
  } catch (e) {
    throw e;
  }
}

class Request {
  static Dio dioClient = _initDio();

  /// get请求
  static Future<T> get<T>(
    String url, {
    Options options,
    Map<String, dynamic> queryParameters,
  }) async {
    return safeRequest(
      url,
      options: options,
      queryParameters: queryParameters,
    );
  }

  /// post请求
  static Future<T> post<T>(
    String url, {
    Options options,
    Object data,
    Map<String, dynamic> queryParameters,
  }) async {
    return safeRequest(
      url,
      options: options?.merge(method: 'POST') ?? Options(method: 'POST'),
      data: data,
      queryParameters: queryParameters,
    );
  }

  /// put请求
  static Future<T> put<T>(
    String url, {
    Options options,
    Object data,
    Map<String, dynamic> queryParameters,
  }) async {
    return safeRequest(
      url,
      options: options?.merge(method: 'PUT') ?? Options(method: 'PUT'),
      data: data,
      queryParameters: queryParameters,
    );
  }
}
