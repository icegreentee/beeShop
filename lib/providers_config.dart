import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'provider/global.p.dart';
import 'provider/themeStore.p.dart';

List<SingleChildWidget> providersConfig = [
  ChangeNotifierProvider<ThemeStore>.value(value: ThemeStore()), // 主题颜色
  ChangeNotifierProvider<GlobalStore>.value(value: GlobalStore()),
];
