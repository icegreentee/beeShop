import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class SalePage extends StatefulWidget {
  SalePage({Key key}) : super(key: key);

  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SaleForm(),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0),
          elevation: 0,
          leading: Center(
            child: TextButton(
              child: Text(
                "取消",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          actions: [
            Container(
              padding: EdgeInsets.only(right: 10),
              width: 80,
              child: Center(
                child: RaisedButton(
                  child: Text("发布"),
                  shape: StadiumBorder(side: BorderSide.none),
                  color: Color.fromRGBO(255, 230, 0, 1),
                  onPressed: () {
                    //发布商品
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SaleForm extends StatefulWidget {
  SaleForm({Key key}) : super(key: key);

  @override
  _SaleFormState createState() => _SaleFormState();
}

class _SaleFormState extends State<SaleForm> {
  final regiterKey = GlobalKey<FormState>();
  String content = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: regiterKey,
        child: Column(
          children: [
            TextFormField(
              minLines: 8,
              maxLines: 8,
              decoration: InputDecoration(border: InputBorder.none),
              onChanged: (value) {
                content = value;
              },
            ),
            Container(
              child: TextButton(
                child: Text('df'),
                onPressed: () {
                  openMultiPhoto();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  openMultiPhoto() async {
    List assets = await MultiImagePicker.pickImages(
      maxImages: 9,
      enableCamera: true,
      materialOptions: MaterialOptions(
          startInAllView: true,
          allViewTitle: '所有照片',
          actionBarColor: '#2196F3',
          textOnNothingSelected: '没有选择照片'),
    );

    if (assets != null && assets.length > 0) {
      for (int i = 0; i < assets.length; i++) {
        Asset asset = assets[i];
        // uploadFile(asset);
        print(assets[i]);
      }
      ;
    }
  }
}
