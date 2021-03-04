import 'package:beeShop/routes/routeName.dart';
import 'package:beeShop/utils/index.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);
  exit() async {
    await SpUtil.removeData("phoneNumber");
    await SpUtil.removeData("name");
    await SpUtil.removeData("school");
    await SpUtil.removeData("qq");
    await SpUtil.removeData("weixin");
    await SpUtil.removeData("avatar");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              Text(
                "我的购买",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Icon(Icons.settings)
            ],
          ),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0),
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Text(
                    "账号与安全",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Text(
                    "使用偏好",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Text(
                    "消息提醒",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            Divider(),
            Container(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Text(
                    "关于beeShop",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Text(
                    "检查更新",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            Divider(),
            Container(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  exit();
                  Navigator.of(context)
                      .pushReplacementNamed(RouteName.loginPage);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Text(
                    "退出登录",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
