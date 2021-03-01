import 'package:flutter/material.dart';

class MyBuy extends StatefulWidget {
  MyBuy({Key key}) : super(key: key);

  @override
  _MyBuyState createState() => _MyBuyState();
}

class _MyBuyState extends State<MyBuy> {
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
      ),
    );
  }
}
