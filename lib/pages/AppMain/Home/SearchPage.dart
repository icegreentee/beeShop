import 'package:beeShop/pages/AppMain/Home/component/TileCard.dart';
import 'package:beeShop/utils/index.dart';
import 'package:beeShop/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.query}) : super(key: key);
  final query;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var goods = [];
  String school = "";
  int _page = 0;
  int _size = 10;
  ScrollController _scrollController = new ScrollController();

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
    var res = await Request.post('/goods/searchgoods',
            data: {'page': _page, "school": school, "word": widget.query})
        .catchError((e) {
      Tips.info("获取失败");
    });
    print(res);
    setState(() {
      if (!_beAdd) {
        goods.clear();
        goods = res;
      } else {
        if (res.length == 0) {
          Tips.info("已到底部");
        } else {
          goods.addAll(res);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
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
                username: goods[i]["username"]);
          },
          staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
          // staggeredTileBuilder: (int index) =>
          //     new StaggeredTile.count(2, index.isEven ? 2 : 3),
          mainAxisSpacing: 30.0,
          crossAxisSpacing: 15.0,
        ),
      ),
    );
  }
}
