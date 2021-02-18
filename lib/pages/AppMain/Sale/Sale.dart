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
      body: ListView(
        children: [],
      ),
    );
  }
}
