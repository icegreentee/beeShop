import 'package:beeShop/pages/AppMain/Home/component/SearchBarDelegate.dart';

import '../../../utils/index.dart';
import 'package:flutter/material.dart';

class SaleList extends StatefulWidget {
  SaleList({Key key, this.params}) : super(key: key);
  final params;

  @override
  _SaleListState createState() => _SaleListState();
}

class _SaleListState extends State<SaleList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                      showSearch(
                          context: context, delegate: SearchBarDelegate());
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
        body: Text("sds"));
  }
}
