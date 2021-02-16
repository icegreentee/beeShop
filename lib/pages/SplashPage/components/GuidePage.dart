import 'package:beeShop/models/userJson.dart';
import 'package:beeShop/routes/routeName.dart';
import 'package:beeShop/utils/request.dart';
import 'package:beeShop/utils/tool/sp_util.dart';
import 'package:beeShop/utils/tool/tips_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class GuidePage extends StatefulWidget {
  GuidePage({Key key}) : super(key: key);

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  String name;
  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  _initAsync() async {
    String name2 = await SpUtil.getData("name");
    setState(() {
      name = name2;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (name != null && name.length > 0) {
      //已有信息
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacementNamed(RouteName.appMain);
      });
    }
    return Container(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 70),
          child: Column(
            children: [
              Center(
                child: Text(
                  "欢迎来到BeeShop",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child:
                    Text("填写以下信息，完成注册", style: TextStyle(color: Colors.grey)),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: FormData(key: childKey),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          childKey.currentState.submitforms();
        },
        child: Icon(Icons.done),
      ),
    ));
  }
}

GlobalKey<FormDataState> childKey = GlobalKey();

class FormData extends StatefulWidget {
  FormData({
    Key key,
  }) : super(key: key);
  FormDataState createState() => FormDataState();
}

class FormDataState extends State<FormData> {
  final regiterKey = GlobalKey<FormState>();
  String usrname, school, qq, weixin;

  void submitforms() async {
    if (regiterKey.currentState.validate()) {
      String phoneNumber = await SpUtil.getData("phoneNumber");
      Map res = await Request.post(
        '/login/info',
        data: {
          'phoneNumber': phoneNumber,
          "name": usrname,
          "school": school,
          "qq": qq,
          "weixin": weixin
        },
      ).catchError((e) {
        Tips.info("后端获取手机号失败");
      });
      print(res);
      var user = new UserJson.fromJson(res);
      if (user.code == 2000) {
        await SpUtil.setData("name", usrname);
        await SpUtil.setData("school", school);
        await SpUtil.setData("qq", qq);
        await SpUtil.setData("weixin", weixin);
        await SpUtil.setData(
            "avatar", "http://q1.qlogo.cn/g?b=qq&nk=" + qq + "&s=640");
        Tips.info(user.msg);
        Navigator.of(context).pushReplacementNamed(RouteName.appMain);
      } else {
        Tips.info(user.msg);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
        key: regiterKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: "昵称", labelStyle: TextStyle(), helperText: ""),
              onChanged: (value) {
                usrname = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return "不可以为空";
                } else if (value.length > 10) {
                  return "最大长度为10";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            DropdownButtonFormField(
              value: school,
              decoration: InputDecoration(labelText: "学校", helperText: ""),
              items: [
                DropdownMenuItem(
                  child: Text('浙江大学'),
                  value: '浙江大学',
                ),
                DropdownMenuItem(child: Text('杭州师范大学'), value: '杭州师范大学'),
                DropdownMenuItem(child: Text('浙江理工大学'), value: '浙江理工大学'),
              ],
              onChanged: (value) {
                setState(() {
                  school = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "QQ", helperText: ""),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (newValue) {
                qq = newValue;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "微信", helperText: ""),
              onChanged: (newValue) {
                weixin = newValue;
              },
            ),
          ],
        ));
  }
}
