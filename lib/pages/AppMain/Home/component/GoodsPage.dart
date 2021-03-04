import 'package:beeShop/utils/index.dart';
import 'package:beeShop/utils/request.dart';
import 'package:beeShop/utils/tool/dateTime.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GoodsPage extends StatefulWidget {
  GoodsPage({Key key, this.id}) : super(key: key);
  final id;
  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> {
  var goods = {};
  String phoneNumber = "";
  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  _initAsync() async {
    String phoneNumber2 = await SpUtil.getData("phoneNumber");
    var res = await Request.post('/goods/getgoodsinfo', data: {
      'id': widget.id,
    }).catchError((e) {
      Tips.info("获取失败");
    });
    setState(() {
      goods = res;
      phoneNumber = phoneNumber2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            GoodsContent(
              username: goods["username"],
              userava: goods["userava"],
              updatetime: goods["updatetime"],
              price: goods["price"],
              content: goods["content"],
              images: goods["images"],
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              height: 60,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.thumb_up_outlined), Text("超赞")],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.mode_comment_outlined),
                            Text("留言")
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.star_border), Text("收藏")],
                        ),
                      ],
                    ),
                    RaisedButton(
                      color: Color.fromRGBO(255, 210, 0, 1),
                      onPressed: () async {
                        // print(phoneNumber);
                        await Request.post(
                          '/sale/buygoods',
                          data: {'goodsid': widget.id, "buyphone": phoneNumber},
                        ).catchError((e) {
                          Tips.info("操作失败");
                        });
                        Tips.info("操作成功");
                        Navigator.of(context).pop(true);
                      },
                      child: Text(
                        "联系购买",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0),
          elevation: 0.0,
          leading: IconButton(
            iconSize: 30,
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              iconSize: 30,
              icon: Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
              onPressed: () {
                print("object");
              },
            )
          ],
        ),
      ),
    );
  }
}

class GoodsContent extends StatelessWidget {
  const GoodsContent(
      {Key key,
      this.username,
      this.userava,
      this.updatetime,
      this.price,
      this.content,
      this.images})
      : super(key: key);
  final username;
  final userava;
  final updatetime;
  final price;
  final content;
  final images;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          userava == null
                              ? "http://static.hdslb.com/images/akari.jpg"
                              : userava,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username == null ? "" : username,
                          ),
                          Text(
                            updatetime == null
                                ? ""
                                : RelativeDateFormat.format(updatetime) + "发布",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  child: Divider(),
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                ),
                Row(
                  children: [
                    Text(
                      "￥",
                      style: TextStyle(
                          // fontSize: 10,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      price == null ? "" : price,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    content == null ? "" : content,
                    style: TextStyle(
                      fontSize: 18,
                      // color: Colors.red,
                    ),
                  ),
                ),
                ImgList(images == null ? [] : images.split("|")),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "12人想要 · 超赞12 · 浏览42",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                )
                //
              ],
            ),
          ),
          Container(
            height: 15,
            color: Color.fromRGBO(243, 244, 248, 1),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(children: [
                    Text("全部留言 · 0",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold))
                  ]),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                  child: Row(children: [
                    ClipOval(
                      child: Image.network(
                        userava == null
                            ? "http://static.hdslb.com/images/akari.jpg"
                            : userava,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 30,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          color: Color.fromRGBO(245, 245, 245, 1),
                          child: Text(
                            "看对眼就留言，问问更多细节",
                            style: TextStyle(
                              color: Color.fromRGBO(179, 179, 179, 1),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
                Divider(),
                Container(
                  height: 200,
                  child: Center(
                    child: Text("还没有人留言哦",
                        style: TextStyle(
                          color: Color.fromRGBO(179, 179, 179, 1),
                        )),
                  ),
                ),
                Container(
                  height: 200,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImgList extends StatelessWidget {
  ImgList(this.images);
  final images;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: images
            .map<Widget>((item) => Container(
                  padding: EdgeInsets.only(bottom: 1),
                  child: Image.network(item),
                ))
            .toList(),
      ),
    );
  }
}
