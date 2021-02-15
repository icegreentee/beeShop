import 'package:beeShop/routes/routeName.dart';
import 'package:flutter/material.dart';

class GuidePage extends StatefulWidget {
  GuidePage({Key key}) : super(key: key);

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text("guide"),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(RouteName.appMain);
        },
      ),
    );
  }
}
