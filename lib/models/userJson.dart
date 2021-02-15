// 演示
class UserJson {
  int code;
  String msg;
  User data;

  UserJson({this.code, this.msg, this.data});

  UserJson.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['code'] = this.code;
  //   data['msg'] = this.msg;
  //   if (this.data != null) {
  //     data['data'] = this.data.toJson();
  //   }
  //   return data;
  // }
}

class User {
  String phoneNumber;
  String name;
  String school;
  String qq;
  String weixin;
  String avatar;

  User(
      {this.phoneNumber,
      this.name,
      this.school,
      this.qq,
      this.weixin,
      this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    name = json['name'];
    school = json['school'];
    qq = json['qq'];
    weixin = json['weixin'];
    avatar = json['avatar'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['authorization'] = this.authorization;
  //   data['userId'] = this.userId;
  //   data['mobile'] = this.mobile;
  //   data['nickname'] = this.nickname;
  //   data['avatar'] = this.avatar;
  //   return data;
  // }
}
