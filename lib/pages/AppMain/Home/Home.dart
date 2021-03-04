import 'package:beeShop/utils/index.dart';
import 'package:beeShop/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:ui';
import 'component/TileCard.dart';
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
  int _page = 0;
  int _size = 10;
  ScrollController _scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => false;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  _initAsync() async {
    String school2 = await SpUtil.getData("school");
    setState(() {
      school = school2;
    });
    _getPostData(true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _addMoreData();
        print('我监听到底部了!');
      }
    });
  }

  Future<void> spsetSchool(school2) async {
    await SpUtil.setData("school", school2);
  }

  // 下拉刷新数据
  Future<Null> _refreshData() async {
    _page = 0;
    _getPostData(false);
  }

  // 上拉加载数据
  Future<Null> _addMoreData() async {
    _page++;
    _getPostData(true);
  }

  void _getPostData(bool _beAdd) async {
    var res = await Request.post('/goods/getgoods', data: {
      'page': _page,
      "school": school,
    }).catchError((e) {
      Tips.info("获取失败");
    });
    setState(() {
      if (!_beAdd) {
        goods.clear();
        goods = res;
      } else {
        if (res.length == 0) {
          // hasBottom();
        } else {
          goods.addAll(res);
        }
      }
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
                      if (value.length > 0) {
                        setState(() {
                          school = value;
                        });
                        spsetSchool(value);
                        _getPostData(false);
                      }
                    })
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  crossAxisCount: 4,
                  itemCount: goods.length,
                  itemBuilder: (context, i) {
                    return TileCard(
                        id: goods[i]["id"],
                        content: goods[i]["content"],
                        image: goods[i]["image"],
                        price: goods[i]["price"],
                        updatetime: goods[i]["updatetime"],
                        userava: goods[i]["userava"],
                        username: goods[i]["username"],
                        refresh: _refreshData);
                  },
                  staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                  // staggeredTileBuilder: (int index) =>
                  //     new StaggeredTile.count(2, index.isEven ? 2 : 3),
                  mainAxisSpacing: 30.0,
                  crossAxisSpacing: 15.0,
                ),
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
                  onPressed: () {
                    showSearch(context: context, delegate: SearchBarDelegate());
                  },
                ),
              )
            ],
          )),
    );
  }
}
