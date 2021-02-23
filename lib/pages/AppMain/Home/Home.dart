import 'package:beeShop/utils/index.dart';
import 'package:beeShop/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
  var goods = [];
  String school = "";

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
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.location_on, color: Color.fromRGBO(255, 210, 0, 1)),
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
                    items: <String>["", '浙江大学', '浙江理工大学', '杭州师范大学']
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
            ),
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: const EdgeInsets.all(8.0),
                crossAxisCount: 4,
                itemCount: goods.length,
                itemBuilder: (context, i) {
                  return itemWidget(i);
                },
                staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                // staggeredTileBuilder: (int index) =>
                //     new StaggeredTile.count(2, index.isEven ? 2 : 3),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
            ),
          ],
        ),
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

  Widget itemWidget(int index) {
    String imgPath = goods[index]["images"].split("|")[0];
    print(imgPath);
    return new Material(
      // elevation: 8.0,
      // borderRadius: new BorderRadius.all(
      //   new Radius.circular(8.0),
      // ),
      color: Color.fromRGBO(255, 255, 255, 0),
      child: new InkWell(
          onTap: () {
            //  Navigator.push(
            //    context,
            //    new MaterialPageRoute(
            //      builder: (context) {
            //        return new FullScreenImagePage(imageurl: imgPath);
            //      },
            //    ),
            //  );
          },
          child: Column(
            children: [
              Container(
                child: Hero(
                  tag: imgPath,
                  child: new Material(
                    color: Colors.transparent,
                    child: new InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   new MaterialPageRoute(
                        //     builder: (context) {
                        //       return new FullScreenImagePage(imageurl: imgPath);
                        //     },
                        //   ),
                        // );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imgPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                padding: EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("dd")],
                ),
              )
            ],
          )),
    );
  }
}
