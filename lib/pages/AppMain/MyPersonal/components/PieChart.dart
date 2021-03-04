import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieSales {
  final String year;
  final int index;
  final int sales;
  final charts.Color color;

  PieSales(this.year, this.sales, this.color, this.index);
}

class ChartPage extends StatefulWidget {
  ChartPage({Key key, this.goods}) : super(key: key);
  final goods;
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<Color> ColorList = [
    Color(0xFFE58382),
    Color(0xFFEA9554),
    Color(0xFFEAE77E),
    Color(0xFF9BDB9F),
    Color(0xFFA4C9E4),
    Color(0xFFD8A3D9),
  ];
  @override
  Widget build(BuildContext context) {
    Map res = Map<String, int>();
    List<PieSales> data = [];
    for (int i = 0; i < widget.goods.length; i++) {
      if (res[widget.goods[i]["goodsclass"]] == null) {
        res.putIfAbsent(widget.goods[i]["goodsclass"], () => 1);
      } else {
        res[widget.goods[i]["goodsclass"]] += 1;
      }
    }

    for (int i = 0; i < res.keys.toList().length; i++) {
      print(res.keys.toList()[i]);
      print(res.keys.toList()[i]);
      data.add(PieSales(res.keys.toList()[i], res[res.keys.toList()[i]],
          charts.ColorUtil.fromDartColor(ColorList[i]), i));
    }

    // var data = [
    //   PieSales("44", 2, charts.ColorUtil.fromDartColor(Color(0xFF126610))),
    // ];

    var seriesList = [
      charts.Series<PieSales, int>(
        id: 'Sales',
        domainFn: (PieSales sales, _) => sales.index,
        measureFn: (PieSales sales, _) => sales.sales,
        colorFn: (PieSales sales, _) => sales.color,
        data: data,
        labelAccessorFn: (PieSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
    return Container(
        height: 300,
        // width: 400,
        padding: EdgeInsets.only(top: 10),
        child: charts.PieChart(seriesList,
            animate: true,
            defaultRenderer: new charts.ArcRendererConfig(
                arcWidth: 60,
                arcRendererDecorators: [
                  new charts.ArcLabelDecorator(
                      labelPosition: charts.ArcLabelPosition.outside)
                ])));
  }
}
