import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'routes/onGenerateRoute.dart';
import 'routes/routesData.dart'; // 路由配置
import 'providers_config.dart'; // providers配置文件
import 'provider/themeStore.p.dart'; // 全局主题
import 'utils/appSetup/index.dart' show appSetupInit;

void main() {
  runApp(MultiProvider(
    providers: providersConfig,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    appSetupInit();
    return Consumer<ThemeStore>(
      builder: (context, themeStore, child) {
        return MaterialApp(
          showPerformanceOverlay: false,
          locale: const Locale('zh', 'CH'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('zh', 'CH'),
            Locale('en', 'US'),
          ],
          theme: themeStore.getTheme,
          initialRoute: initialRoute,
          onGenerateRoute: onGenerateRoute, // 路由处理
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
