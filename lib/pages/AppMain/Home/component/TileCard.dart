import 'package:beeShop/config/app_env.dart';
import 'package:beeShop/pages/AppMain/Home/component/goodsPage.dart';
import 'package:flutter/material.dart';
import 'package:beeShop/utils/tool/dateTime.dart';

class TileCard extends StatelessWidget {
  final String id;
  final String content;
  final String image;
  final String price;
  final String updatetime;
  final String userava;
  final String username;
  final refresh;
  TileCard(
      {this.id,
      this.content,
      this.image,
      this.price,
      this.updatetime,
      this.userava,
      this.username,
      this.refresh});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
      // elevation: 8.0,
      // borderRadius: new BorderRadius.all(
      //   new Radius.circular(8.0),
      // ),
      color: Color.fromRGBO(255, 255, 255, 0),
      child: new InkWell(
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) {
                  return GoodsPage(id: id);
                },
              ),
            ).then((value) {
              if (value == null) {
              } else {
                refresh();
              }
            });
          },
          child: Column(
            children: [
              Container(
                child: new Material(
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      appEnv.baseImgUrl + image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                // height: 30,
                padding: EdgeInsets.only(top: 5),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content,
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "￥",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Text(
                    RelativeDateFormat.format(updatetime),
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      userava,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(username,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ))
                ],
              )
            ],
          )),
    ));
  }
}
