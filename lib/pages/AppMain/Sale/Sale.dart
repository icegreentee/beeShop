import 'package:beeShop/pages/AppMain/Sale/SalePage.dart';

import '../../../utils/index.dart';
import 'package:flutter/material.dart';

class Sale extends StatefulWidget {
  Sale({Key key, this.params}) : super(key: key);
  final params;

  @override
  _SaleState createState() => _SaleState();
}

class _SaleState extends State<Sale> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    LogUtil.d(widget.params);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          '出售流程',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        )),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0),
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: ListView(
        children: List.generate(1, (index) {
          return Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("1."),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.ad_units),
                      SizedBox(
                        width: 5,
                      ),
                      Text("发布物品信息")
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("2."),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.ad_units),
                      SizedBox(
                        width: 5,
                      ),
                      Text("沟通确定物品信息")
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("3."),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.ad_units),
                      SizedBox(
                        width: 5,
                      ),
                      Text("通过微信或者qq进行联系，线下交易")
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SalePage();
                      }));
                    },
                    child: Text("了解出售流程后，点击进行发布"),
                    shape: StadiumBorder(side: BorderSide.none),
                    color: Color.fromRGBO(255, 230, 0, 1),
                    padding: EdgeInsets.all(10),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
