import 'package:beeShop/pages/AppMain/MyPersonal/components/MyBuy.dart';
import 'package:beeShop/pages/AppMain/MyPersonal/components/MySale.dart';
import 'package:beeShop/pages/AppMain/MyPersonal/components/SettingPage.dart';
import 'package:beeShop/utils/index.dart';
import 'package:flutter/material.dart';

class MyPersonal extends StatefulWidget {
  @override
  _MyPersonalState createState() => _MyPersonalState();
}

class _MyPersonalState extends State<MyPersonal>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initAsync();
  }

  String ava;
  _initAsync() async {
    String ava2 = await SpUtil.getData("avatar");

    setState(() {
      ava = ava2;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.settings),
            Text(
              "",
            ),
            InkWell(
              child: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) {
                    return SettingPage();
                  },
                ));
              },
            )
          ],
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0),
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    ava == null
                        ? "http://static.hdslb.com/images/akari.jpg"
                        : ava,
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("sss",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("0", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("收藏",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ))
                  ],
                ),
                Column(
                  children: [
                    Text("4", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("历史",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ))
                  ],
                ),
                Column(
                  children: [
                    Text("0", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("点赞",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ))
                  ],
                ),
                Column(
                  children: [
                    Text("0", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("发布量",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ))
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Color.fromRGBO(240, 240, 240, 1),
            height: 6,
            margin: EdgeInsets.only(top: 20, bottom: 20),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Text(
              "我的交易",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Column(
                    children: [
                      Icon(Icons.shopping_bag_outlined),
                      Text(
                        "我的购买",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) {
                        return MyBuy();
                      },
                    ));
                  },
                ),
                InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.store_outlined),
                        Text("我的出售",
                            style: TextStyle(fontSize: 12, color: Colors.grey))
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) {
                          return MySale();
                        },
                      ));
                    }),
                InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.timeline),
                        Text("出售统计",
                            style: TextStyle(fontSize: 12, color: Colors.grey))
                      ],
                    ),
                    onTap: () {}),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Divider(),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Text(
              "更多",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Column(
                    children: [
                      Icon(Icons.card_giftcard),
                      Text(
                        "我的卡卷",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
                InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.supervisor_account),
                        Text("好友",
                            style: TextStyle(fontSize: 12, color: Colors.grey))
                      ],
                    ),
                    onTap: () {}),
                InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.sentiment_very_satisfied),
                        Text("帮助中心",
                            style: TextStyle(fontSize: 12, color: Colors.grey))
                      ],
                    ),
                    onTap: () {}),
                InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.comment_bank_outlined),
                        Text("问题反馈",
                            style: TextStyle(fontSize: 12, color: Colors.grey))
                      ],
                    ),
                    onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
