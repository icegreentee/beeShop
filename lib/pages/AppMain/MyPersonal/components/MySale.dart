import 'package:beeShop/utils/index.dart';
import 'package:beeShop/utils/request.dart';
import 'package:beeShop/utils/tool/dateTime.dart';
import 'package:flutter/material.dart';

class MySale extends StatefulWidget {
  MySale({Key key}) : super(key: key);

  @override
  _MySaleState createState() => _MySaleState();
}

class _MySaleState extends State<MySale> {
  var goods = [];
  String phoneNumber = "";

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
    var res = await Request.post('/person/getmysale',
        data: {'phoneNumber': phoneNumber}).catchError((e) {
      Tips.info("获取失败");
    });
    setState(() {
      goods.clear();
      goods = res;
    });
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
        body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
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
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(top: 5),
                child: RefreshIndicator(
                    child: ListView.builder(
                        itemCount: goods.length == null ? 0 : goods.length,
                        itemBuilder: (conttext, int index) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  RelativeDateFormat.dateAndTimeToString(
                                      goods[index]["buytime"] == null
                                          ? DateTime.now()
                                          : goods[index]["buytime"],
                                      formart: {
                                        "y-m": "-",
                                        "m-d": "-",
                                        "h-m": ":"
                                      }),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                margin: EdgeInsets.only(top: 5),
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
                                              goods[index]["image"] == null
                                                  ? "http://static.hdslb.com/images/akari.jpg"
                                                  : goods[index]["image"],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          width: 60,
                                          height: 60,
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
                                                    onTap: () {},
                                                    child: Text(
                                                      goods[index][
                                                                  "goodsname"] ==
                                                              null
                                                          ? ""
                                                          : goods[index]
                                                              ["goodsname"],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  )),
                                              Row(
                                                children: [
                                                  Text(
                                                    goods[index]["price"] ==
                                                            null
                                                        ? ""
                                                        : "￥" +
                                                            goods[index]
                                                                ["price"],
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "出售成功",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Divider()
                            ],
                          );
                        }),
                    onRefresh: _refreshData),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
