import 'package:beeShop/pages/AppMain/Home/component/GoodsPage.dart';
import 'package:beeShop/pages/AppMain/Home/component/SearchBarDelegate.dart';
import 'package:beeShop/utils/request.dart';

import '../../../utils/index.dart';
import 'package:flutter/material.dart';

enum Action { Ok, Cancel }

class SaleList extends StatefulWidget {
  SaleList({Key key, this.params}) : super(key: key);
  final params;

  @override
  _SaleListState createState() => _SaleListState();
}

class _SaleListState extends State<SaleList>
    with AutomaticKeepAliveClientMixin {
  String phoneNumber;
  var goods = [];
  @override
  bool get wantKeepAlive => false;
  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  _initAsync() async {
    String phoneNumber2 = await SpUtil.getData("phoneNumber");

    setState(() {
      phoneNumber = phoneNumber2;
    });
    _getPostData();
  }

  void _getPostData() async {
    var res = await Request.post('/sale/getsalegoods',
        data: {'phoneNumber': phoneNumber}).catchError((e) {
      Tips.info("获取失败");
    });
    setState(() {
      goods.clear();
      goods = res;
    });
  }

  Future<Null> _refreshData() async {
    _getPostData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> deleteGoods(String id) async {
    await Request.post('/sale/deletesalegoods', data: {'id': id})
        .catchError((e) {
      Tips.info("获取失败");
    });
    Tips.info("删除成功");
  }

  // String _choice = 'Nothing';

  Future _openAlertDialog(String id) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false, //// user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('是否删除?'),
          actions: <Widget>[
            FlatButton(
              child: Text('取消', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.pop(context, Action.Cancel);
              },
            ),
            FlatButton(
              child: Text(
                '确认',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                deleteGoods(id);
                Navigator.pop(context, Action.Ok);
              },
            ),
          ],
        );
      },
    );

    switch (action) {
      case Action.Ok:
        _refreshData();
        break;
      case Action.Cancel:
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      // showSearch(
                      //     context: context, delegate: SearchBarDelegate());
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
        body: Container(
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
                itemCount: goods.length,
                itemBuilder: (conttext, int index) {
                  return Container(
                      // color: Colors.green,
                      // margin: EdgeInsets.only(top: ),

                      child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      goods[index]["images"].split("|")[0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: 40,
                                  height: 40,
                                ),
                                Container(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 100,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                  builder: (context) {
                                                    return GoodsPage(
                                                        id: goods[index]["id"]);
                                                  },
                                                ),
                                              );
                                            },
                                            child: Text(
                                              goods[index]["content"],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )),
                                      Row(
                                        children: [
                                          Text(
                                            "当前状态:",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ),
                                          saleInfo(
                                            onsale: goods[index]["onsale"],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      //只有上架中的才能删除
                                      if (goods[index]["onsale"]) {
                                        _openAlertDialog(goods[index]["id"]);
                                      } else {
                                        Tips.info("此时不可以删除");
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              174, 174, 174, 0.5),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5),
                                      child: Text(
                                        "删除",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                      // color: Colors.green,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  ));
                }),
          ),
          padding: EdgeInsets.only(top: 10, bottom: 20),
        ));
  }
}

class saleInfo extends StatelessWidget {
  const saleInfo({Key key, this.onsale}) : super(key: key);
  final onsale;

  @override
  Widget build(BuildContext context) {
    if (onsale) {
      return Container(
        child: Text(
          "已上架",
          style: TextStyle(fontSize: 10, color: Colors.green),
        ),
      );
    } else {
      return Container(
        child: Text(
          "下架中",
          style: TextStyle(fontSize: 10, color: Colors.red),
        ),
      );
    }
  }
}
