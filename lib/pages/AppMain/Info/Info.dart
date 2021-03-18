import 'package:beeShop/config/app_env.dart';
import 'package:beeShop/utils/index.dart';
import 'package:beeShop/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Action { Ok, Cancel }

class InfoPage extends StatefulWidget {
  InfoPage({Key key, this.params}) : super(key: key);
  final params;
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with AutomaticKeepAliveClientMixin {
  String phoneNumber = "";
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

  Future<Null> _refreshData() async {
    _getPostData();
  }

  void _getPostData() async {
    var res = await Request.post('/info/getsalegoodsinfo',
        data: {'phoneNumber': phoneNumber}).catchError((e) {
      Tips.info("获取失败");
    });
    setState(() {
      goods.clear();
      goods = res;
    });
  }

  Future opendia1(id) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false, //// user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('是否确认同意进行交易?确认后将获得买家信息。'),
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
                acceptBuy(id);
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

  void acceptBuy(id) async {
    await Request.post('/info/accept', data: {'id': id}).catchError((e) {
      Tips.info("操作失败");
    });
    Tips.info("操作成功");
    Navigator.pop(context, Action.Ok);
  }

  Future opendia2(id) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false, //// user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('是否拒绝交易?拒绝后商品将重新上架。'),
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
                refuseBuy(id);
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

  void refuseBuy(id) async {
    await Request.post('/info/noaccept', data: {'id': id}).catchError((e) {
      Tips.info("操作失败");
    });
    Tips.info("操作成功");
    Navigator.pop(context, Action.Ok);
  }

  Future opendia3(id) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false, //// user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('是否确认交易?操作后表示商品交易成功。'),
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
                buysuccess(id);
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

  void buysuccess(id) async {
    await Request.post('/info/finishsale', data: {'id': id}).catchError((e) {
      Tips.info("操作失败");
    });
    Tips.info("操作成功");
    Navigator.pop(context, Action.Ok);
  }

  Future opendia4(id) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false, //// user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('是否拒绝交易?拒绝后商品将重新上架。'),
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
                buyfail(id);
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

  void buyfail(id) async {
    await Request.post('/info/nofinishsale', data: {'id': id}).catchError((e) {
      Tips.info("操作失败");
    });
    Tips.info("操作成功");
    Navigator.pop(context, Action.Ok);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.settings),
              Text(
                "消息",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.settings,
                color: Colors.black,
              )
            ],
          ),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0),
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: goods == null || goods.length == 0
            ? Container(
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  children: [Text("暂无消息"), Divider()],
                ),
              )
            : Container(
                child: RefreshIndicator(
                onRefresh: _refreshData,
                child: ListView.builder(
                    itemCount: goods == null ? 0 : goods.length,
                    itemBuilder: (conttext, int index) {
                      if (goods[index]["accept"] != "") {
                        return Container(
                            child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  appEnv.baseImgUrl +
                                                      goods[index]
                                                          ["goodsiamge"],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              width: 60,
                                              height: 60,
                                            ),
                                            Container(
                                              height: 60,
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: 100,
                                                      child: InkWell(
                                                        onTap: () {
                                                          // Navigator.push(
                                                          //   context,
                                                          //   new MaterialPageRoute(
                                                          //     builder: (context) {
                                                          //       return GoodsPage(
                                                          //           id: goods[index]["id"]);
                                                          //     },
                                                          //   ),
                                                          // );
                                                        },
                                                        child: Text(
                                                          goods[index]
                                                              ["content"],
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      )),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "￥" +
                                                            goods[index]
                                                                ["price"],
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.orange),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("购买者：",
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.grey,
                                                          )),
                                                      ClipOval(
                                                        child: Image.network(
                                                          goods[index]
                                                              ["buyerava"],
                                                          width: 20,
                                                          height: 20,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          goods[index]
                                                              ["buyername"],
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.grey,
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Center(
                                            child: Text(
                                          "已同意，交易中",
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        ))
                                      ],
                                    ),
                                    Divider(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          Text("QQ:"),
                                          SelectableText(
                                              goods[index]["buyerqq"]),
                                          TextButton(
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: goods[index]
                                                        ["buyerqq"]));
                                                Tips.info("已复制到粘贴板");
                                              },
                                              child: Text("复制"))
                                        ]),
                                        Row(
                                          children: [
                                            Text("微信:"),
                                            SelectableText(
                                                goods[index]["buyerweixin"]),
                                            TextButton(
                                                onPressed: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: goods[index]
                                                              ["buyerweixin"]));
                                                  Tips.info("已复制到粘贴板");
                                                },
                                                child: Text("复制"))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("手机号:"),
                                            SelectableText(
                                                goods[index]["buyerphone"]),
                                            TextButton(
                                                onPressed: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: goods[index]
                                                              ["buyerphone"]));
                                                  Tips.info("已复制到粘贴板");
                                                },
                                                child: Text("复制"))
                                          ],
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              opendia3(goods[index]["saleid"]);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 5,
                                                  bottom: 5),
                                              child: Text(
                                                "交易成功",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                              // color: Colors.green,
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              opendia4(goods[index]["saleid"]);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 5,
                                                  bottom: 5),
                                              child: Text(
                                                "交易失败",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                              // color: Colors.green,
                                            )),
                                      ],
                                    )
                                  ],
                                )),
                            Divider()
                          ],
                        ));
                      } else {
                        return Container(
                            child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            appEnv.baseImgUrl +
                                                goods[index]["goodsiamge"],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        width: 60,
                                        height: 60,
                                      ),
                                      Container(
                                        height: 60,
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
                                                    // Navigator.push(
                                                    //   context,
                                                    //   new MaterialPageRoute(
                                                    //     builder: (context) {
                                                    //       return GoodsPage(
                                                    //           id: goods[index]["id"]);
                                                    //     },
                                                    //   ),
                                                    // );
                                                  },
                                                  child: Text(
                                                    goods[index]["content"],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )),
                                            Row(
                                              children: [
                                                Text(
                                                  "￥" + goods[index]["price"],
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.orange),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("购买者：",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey,
                                                    )),
                                                ClipOval(
                                                  child: Image.network(
                                                    goods[index]["buyerava"],
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(goods[index]["buyername"],
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey,
                                                    ))
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
                                            opendia1(goods[index]["saleid"]);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    255, 210, 0, 1),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                top: 5,
                                                bottom: 5),
                                            child: Text(
                                              "同意",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                            // color: Colors.green,
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            opendia2(goods[index]["saleid"]);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    174, 174, 174, 0.5),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                top: 5,
                                                bottom: 5),
                                            child: Text(
                                              "拒绝",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
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
                      }
                    }),
              )),
      ),
    );
  }
}
