import 'package:shared_preferences/shared_preferences.dart';
// import 'package:synchronized/synchronized.dart';

/// shared_preferences缓存插件方法封装
class SpUtil {
  // 保存数据
  static Future setData(String key, value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  // 获取数据
  static Future<String> getData(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  // 清除数据
  static Future removeData(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }
}
