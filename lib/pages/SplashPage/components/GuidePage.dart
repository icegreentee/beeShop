import 'package:beeShop/pages/SplashPage/provider/splashStore.p.dart';
import 'package:beeShop/routes/routeName.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GuidePage extends StatefulWidget {
  GuidePage({Key key}) : super(key: key);

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  SplashStore splashStore;
  @override
  Widget build(BuildContext context) {
    splashStore = Provider.of<SplashStore>(context);
    return Container(
      child: TextButton(
        child: Text("guide"),
        onPressed: () {
          // Navigator.of(context).pushReplacementNamed(RouteName.appMain);
          splashStore.decrement();
        },
      ),
    );
  }
}
