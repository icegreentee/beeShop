import 'package:beeShop/utils/index.dart';
import 'package:beeShop/utils/request.dart';
import 'package:beeShop/utils/tool/dateTime.dart';
import 'package:flutter/material.dart';

class SaleCount extends StatefulWidget {
  SaleCount({Key key}) : super(key: key);

  @override
  _SaleCountState createState() => _SaleCountState();
}

class _SaleCountState extends State<SaleCount> {
  var goods = [];
  String phoneNumber = "";
  Choice _selectedChoice = choices[4]; // The app's "state".

  void _select(Choice choice) {
    setState(() {
      // Causes the app to rebuild with the new _selectedChoice.
      _selectedChoice = choice;
    });
  }

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
          actions: [
            new PopupMenuButton<Choice>(
              // overflow menu
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return new PopupMenuItem<Choice>(
                    value: choice,
                    child: new Text(choice.title),
                  );
                }).toList();
              },
            ),
          ],
          // backgroundColor: Color.fromRGBO(255, 255, 255, 0),
          leading: Icon(Icons.keyboard_arrow_left),
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(255, 210, 0, 1),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                color: Color.fromRGBO(255, 210, 0, 1),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        child: Text(
                          _selectedChoice.title + "售出金额",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Center(
                      child: Text("￥ " + getallprice(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold)),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(_selectedChoice.title + "售出件数",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(getallgoods(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Text("d"),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getallprice() {
    int allprice = 0;
    if (_selectedChoice.title == "累计") {
      for (int i = 0; i < goods.length; i++) {
        allprice += int.parse(goods[i]["price"]);
      }
    } else if (_selectedChoice.title == "今天") {
      for (int i = 0; i < goods.length; i++) {
        if (RelativeDateFormat.istoDay(goods[i]["buytime"]))
          allprice += int.parse(goods[i]["price"]);
      }
    } else if (_selectedChoice.title == "昨天") {
      for (int i = 0; i < goods.length; i++) {
        if (RelativeDateFormat.isyesDay(goods[i]["buytime"]))
          allprice += int.parse(goods[i]["price"]);
      }
    } else if (_selectedChoice.title == "最近7天") {
      for (int i = 0; i < goods.length; i++) {
        if (RelativeDateFormat.isbeforenDay(7, goods[i]["buytime"]))
          allprice += int.parse(goods[i]["price"]);
      }
    } else if (_selectedChoice.title == "最近30天") {
      for (int i = 0; i < goods.length; i++) {
        if (RelativeDateFormat.isbeforenDay(30, goods[i]["buytime"]))
          allprice += int.parse(goods[i]["price"]);
      }
    }
    return allprice.toString();
  }

  String getallgoods() {
    var goodscount = [];
    if (_selectedChoice.title == "累计") {
      goodscount = goods;
    } else if (_selectedChoice.title == "今天") {
      for (int i = 0; i < goods.length; i++) {
        if (RelativeDateFormat.istoDay(goods[i]["buytime"])) goodscount.add("");
      }
    } else if (_selectedChoice.title == "昨天") {
      for (int i = 0; i < goods.length; i++) {
        if (RelativeDateFormat.isyesDay(goods[i]["buytime"]))
          goodscount.add("");
      }
    } else if (_selectedChoice.title == "最近7天") {
      for (int i = 0; i < goods.length; i++) {
        if (RelativeDateFormat.isbeforenDay(7, goods[i]["buytime"]))
          goodscount.add("");
      }
    } else if (_selectedChoice.title == "最近30天") {
      for (int i = 0; i < goods.length; i++) {
        if (RelativeDateFormat.isbeforenDay(30, goods[i]["buytime"]))
          goodscount.add("");
      }
    }
    return goodscount.length.toString();
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '今天', icon: Icons.directions_car),
  const Choice(title: '昨天', icon: Icons.directions_bike),
  const Choice(title: '最近7天', icon: Icons.directions_boat),
  const Choice(title: '最近30天', icon: Icons.directions_bus),
  const Choice(title: '累计', icon: Icons.directions_railway),
];
