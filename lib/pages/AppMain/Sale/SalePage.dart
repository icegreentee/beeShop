import 'dart:typed_data';
import 'package:beeShop/config/app_env.dart';
import 'package:beeShop/utils/index.dart';
import 'package:beeShop/utils/request.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: SaleForm(key: childKey),
      ),
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
                  childKey.currentState.submitforms();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

GlobalKey<_SaleFormState> childKey = GlobalKey();

class SaleForm extends StatefulWidget {
  SaleForm({Key key}) : super(key: key);

  @override
  _SaleFormState createState() => _SaleFormState();
}

class _SaleFormState extends State<SaleForm> {
  final regiterKey = GlobalKey<FormState>();
  String content = "";
  List<String> imglists = [];
  String school = "";
  String classNow = "电子数码";
  String price = "";

  void submitforms() async {
    String phoneNumber = await SpUtil.getData("phoneNumber");
    Map res = await Request.post(
      '/goods/submit',
      data: {
        'phoneNumber': phoneNumber,
        "content": content,
        "imglists": imglists,
        "school": school,
        "class": classNow,
        "price": price
      },
    ).catchError((e) {
      Tips.info("发布失败");
    });
    Tips.info("发布成功");
    Navigator.pop(context);
  }

  List<String> _tags = [
    '电子数码',
    '运动户外',
    '服装',
    '日用品',
    '食品',
    '其他',
  ];
  List<Widget> imageshows = [];
  List<Widget> tags = [];
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      imageshows.add(Container(
        decoration: new BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Center(
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              uploadImages();
            },
          ),
        ),
        width: 120,
        height: 120,
      ));
    });
    _initSync();
  }

  Future<void> _initSync() async {
    String school2 = await SpUtil.getData("school");
    setState(() {
      school = school2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: regiterKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              minLines: 4,
              maxLines: 4,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "描述物品的状况等信息",
                  contentPadding: EdgeInsets.only(left: 10, right: 10)),
              onChanged: (value) {
                content = value;
              },
            ),
            Container(
              width: double.infinity,
              child: Wrap(
                spacing: 8.0, // 主轴(水平)方向间距
                runSpacing: 8.0, // 纵轴（垂直）方向间距
                alignment: WrapAlignment.spaceAround, //沿主轴方向居中
                children: imageshows,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Chip(
                backgroundColor: Colors.grey[200],
                avatar: Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                label: Text(
                  school,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(children: [
                Text("分类:"),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Container(
                  ///container 高度
                  height: 50.0,
                  child: new ListView(
                      scrollDirection: Axis.horizontal,
                      children: _tags
                          .map((i) => Row(
                                children: [
                                  ChoiceChip(
                                      label: Text(
                                        i,
                                        // style: TextStyle(color: Colors.orange),
                                      ),
                                      selected: classNow == i,
                                      selectedColor: Colors.yellow,
                                      backgroundColor: Colors.grey[200],
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      onSelected: (val) {
                                        setState(() {
                                          classNow = i;
                                        });
                                      }),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ))
                          .toList()),
                ))
              ]),
            ),
            Divider(),
            Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('价格'),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            child: TextField(
                              textAlign: TextAlign.end,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  price = val;
                                });
                              },
                              autofocus: false,
                            ),
                          ),
                          Text('元')
                        ],
                      ),
                      width: 100,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            SizedBox(
              height: 300,
            )
          ],
        ),
      ),
    );
  }

  List<Asset> images = List<Asset>();
  // 选择照片并上传
  Future<void> uploadImages() async {
    setState(() {
      images = List<Asset>();
    });
    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        // 选择图片的最大数量
        maxImages: 9,
        // 是否支持拍照
        enableCamera: true,
        materialOptions: MaterialOptions(
            // 显示所有照片，值为 false 时显示相册
            startInAllView: true,
            allViewTitle: '所有照片',
            actionBarColor: '#2196F3',
            textOnNothingSelected: '没有选择照片'),
      );
    } on Exception catch (e) {
      e.toString();
    }

    if (!mounted) return;
    images = (resultList == null) ? [] : resultList;
    // 上传照片时一张一张上传
    for (int i = 0; i < images.length; i++) {
      // 获取 ByteData
      ByteData byteData = await images[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();

      MultipartFile multipartFile = MultipartFile.fromBytes(
        imageData,
        // 文件名
        filename: 'some-file-name.jpg',
        // 文件类型
        contentType: MediaType("image", "jpg"),
      );
      String phone = await SpUtil.getData("phoneNumber");
      FormData formData = FormData.fromMap({
        // 后端接口的参数名称
        "files": multipartFile,
        "phone": phone
      });
      Map res = await Request.post('/upload/goodsimage', data: formData)
          .catchError((e) {
        Tips.info("上传失败");
      });
      setState(() {
        imglists.add(appEnv.baseImgUrl + "/uploads/" + res["fileName"]);
        imageshows.insert(
            0,
            Container(
              child: Image.network(
                appEnv.baseImgUrl + "/uploads/" + res["fileName"],
                fit: BoxFit.cover,
              ),
              width: 120,
              height: 120,
            ));
      });
    }
  }
}
