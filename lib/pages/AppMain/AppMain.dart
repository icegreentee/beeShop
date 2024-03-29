import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../routes/routeName.dart';
import '../../config/app_env.dart' show appEnv, ENV_TYPE;
import '../../config/app_config.dart';
import '../../components/DoubleBackExitApp/DoubleBackExitApp.dart';
import '../../provider/global.p.dart';
import 'Info/Info.dart';
import 'MyPersonal/MyPersonal.dart';
import 'Sale/Sale.dart';
import 'SaleList/SaleList.dart';
import 'Home/Home.dart';

/// [params] 别名路由传递的参数
/// [params.pageId] 跳转到指定tab页面（0第一页），如果不是别名路由跳转的话，又想实现跳转到指定tab页面，推荐别名路由跳转方式。
///```dart
/// // 手动传入参数跳转路由方式如下：
/// Navigator.of(context).push(
///   MaterialPageRoute(
///     builder: (context) => BarTabs(
///       params: {'pageId': 2}, // 跳转到tabs的第三个页面
///     ),
///   )
/// );
///
/// // 别名路由跳转方式如下：
/// Navigator.pushNamed(context, '/testDemo', arguments: {
///   'pageId': 2,
/// });
/// ```
class AppMain extends StatefulWidget {
  final params;

  AppMain({
    Key key,
    this.params,
  }) : super(key: key);

  @override
  _AppMainState createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> with AutomaticKeepAliveClientMixin {
  int currentIndex = 0; // 接收bar当前点击索引
  bool physicsFlag = true; // 是否禁止左右滑动跳转tab
  GlobalStore appPageStore;
  PageController pageController;
  @override
  bool get wantKeepAlive => true;

  // app主页底部bar
  final List<Map<String, dynamic>> appBottomBar = [
    {
      'title': '首页',
      'icon': Icons.home,
      'body': Home(),
    },
    {
      'title': '出售',
      'icon': Icons.whatshot,
      'body': Sale(),
    },
    {
      'title': '在售',
      'icon': Icons.store,
      'body': SaleList(),
    },
    {
      'title': '消息',
      'icon': Icons.insert_comment,
      'body': InfoPage(),
    },
    {
      'title': '我的',
      'icon': Icons.person,
      'body': MyPersonal(),
    },
  ];

  @override
  void initState() {
    super.initState();

    handleCurrentIndex();
    initTools();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appPageStore.saveController(pageController);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  /// 处理tab默认显示索引
  handleCurrentIndex() {
    if (widget.params != null) {
      // 默认加载页面
      currentIndex = widget.params['pageId'] ?? 0 >= (appBottomBar.length)
          ? (appBottomBar.length - 1)
          : widget.params['pageId'];
    }

    // 初始化tab控制器
    pageController = PageController(initialPage: currentIndex, keepPage: true);
  }

  /// 初始化第三方插件插件
  initTools() {}

  @override
  Widget build(BuildContext context) {
    super.build(context);
    appPageStore = Provider.of<GlobalStore>(context);

    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        appPageStore.getGrayTheme ? Color(0xff757575) : Colors.transparent,
        BlendMode.color,
      ),
      child: _scaffoldBody(),
    );
  }

  /// 页面Scaffold层组件
  Widget _scaffoldBody() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            controller: pageController,
            physics: physicsFlag ? NeverScrollableScrollPhysics() : null,
            children: bodyWidget(), // tab页面主体
            // 监听滑动
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          Positioned(
            bottom: 30,
            child: DoubleBackExitApp(),
          ),
        ],
      ),

      // 底部栏
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex, // 当前页
        elevation: 5.0,
        selectedFontSize: 26.sp, // 选中的字体大小
        unselectedFontSize: 26.sp, // 未选中的字体大小
        onTap: (int idx) async {
          setState(() {
            currentIndex = idx;
          });
          pageController.jumpToPage(idx); // 跳转
        },
        items: _generateBottomBars(), // 底部菜单导航
        selectedItemColor: Colors.black,
        unselectedItemColor: Color.fromRGBO(174, 174, 174, 1),
      ),
    );
  }

  /// tab视图内容区域
  List<Widget> bodyWidget() {
    try {
      return appBottomBar
          .map((itemData) => itemData['body'] as Widget)
          .toList();
    } catch (e) {
      throw Exception('appBottomBar变量缺少body参数，errorMsg:$e');
    }
  }

  /// 生成底部菜单导航
  List<BottomNavigationBarItem> _generateBottomBars() {
    try {
      return appBottomBar.map<BottomNavigationBarItem>((itemData) {
        return BottomNavigationBarItem(
          icon: Icon(
            itemData['icon'], // 图标
            size: 44.sp,
          ),
          label: itemData['title'],
          activeIcon: Icon(
            itemData['icon'], // 图标
            size: 44.sp,
            color: Color.fromRGBO(255, 210, 0, 1),
          ),
        );
      }).toList();
    } catch (e) {
      throw Exception('appBottomBar数据缺少参数、或字段类型不匹配, errorMsg:$e');
    }
  }
}
