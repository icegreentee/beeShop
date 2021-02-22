import 'package:beeShop/utils/index.dart';
import 'package:beeShop/utils/request.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'component/SearchBarDelegate.dart';

class Home extends StatefulWidget {
  Home({Key key, this.params}) : super(key: key);
  final params;

  @override
  _HomeState createState() => _HomeState();
}
//  Navigator.pushNamed(
//                     context,
//                     '/testDemo',
//                     arguments: {'data': '别名路由传参666'},
//                   );

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  var goods;
  String school = "";
  final controller = TextEditingController();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  _initAsync() async {
    // String phoneNumber = await SpUtil.getData("phoneNumber");
    // String name = await SpUtil.getData("name");
    // String school = await SpUtil.getData("school");
    // String qq = await SpUtil.getData("qq");
    // String weixin = await SpUtil.getData("weixin");
    // String avatar = await SpUtil.getData("avatar");
    // print("phoneNumber:" + phoneNumber);
    // print("name:" + name);
    // print("school:" + school);
    // print("qq:" + qq);
    // print("weixin:" + weixin);
    // print("avatar:" + avatar);
    var res = await Request.get(
      '/goods/getgoods',
    ).catchError((e) {
      Tips.info("发布失败");
    });

    String school2 = await SpUtil.getData("school");
    setState(() {
      school = school2;
      goods = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.location_on,
                color: Colors.grey,
              ),
              SizedBox(
                width: 20,
              ),
              DropdownButton(
                  value: school,
                  elevation: 0,
                  underline: SizedBox(),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  items: <String>['浙江大学', '浙江理工大学', '杭州师范大学']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      school = value;
                    });
                  })
            ],
          )
        ],
      ),
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0),
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: Container(
                height: 35,
                // width: MediaQuery.of(context).size.width - 64,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(230, 230, 230, 1.0),
                    borderRadius: BorderRadius.circular(20)),
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(Icons.search, color: Colors.grey)),
                      Text(
                        "点我进行搜索",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      )
                    ],
                  ),
                  onTap: () {
                    //这里是跳转搜索界面的关键
                    showSearch(context: context, delegate: SearchBarDelegate());
                  },
                ),
              )),
              Container(
                // height: 35,
                width: 40,
                child: TextButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.subject,
                        color: Colors.black,
                      )
                    ],
                  ),
                  onPressed: () {},
                ),
              )
            ],
          )),
    );
  }
}
