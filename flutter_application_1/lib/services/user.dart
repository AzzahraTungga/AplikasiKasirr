import 'dart:convert';
import 'package:flutter_application_1/models/response_data_map.dart';
import 'url.dart' as url;
import 'package:http/http.dart' as http;
import '../models/user_login.dart';
import '../models/response_data_map.dart';

class UserService {
  Future<ResponseDataMap> registerUser(data) async {
    var uri = Uri.parse(url.baseUrl + "/auth/register");
    var register = await http.post(uri, body: data);
    if (register.statusCode == 200) {
      var data = json.decode(register.body);
      if (data["status"] == true) {
        ResponseDataMap response = ResponseDataMap(
          status: true,
          message: "Sukses menambah user",
          data: data,
        );
        return response;
      } else {
        var message = '';
        for (String key in data["message"].keys) {
          message += data["message"][key][0].toString() + '\n';
        }
        ResponseDataMap response = ResponseDataMap(
          status: false,
          message: message,
        );
        return response;
      }
    } else {
      ResponseDataMap response = ResponseDataMap(
        status: false,
        message: "gagal menambah user dengan code error ${register.statusCode}",
      );
      return response;
    }
  }
  Future loginUser(data) async {
  var uri = Uri.parse(url.baseUrl + "/auth/login");
  var register = await http.post(uri, body: data);
  if (register.statusCode == 200) {
    var data = json.decode(register.body);
    if (data["status"] == true) {
      UserLogin userLogin = UserLogin(
        status: data["status"],
        token: data["token"],
        message: data["message"],
        id: data["user"]["id"],
        nama_user: data["user"]["nama_user"],
        email: data["user"]["email"],
        role: data["user"]["role"],
      );
      await userLogin.prefs();
      ResponseDataMap response = ResponseDataMap(
        status: true, 
        message: "Sukses login user",
        data: data,
      );
      return response;
    } else {
      ResponseDataMap response = ResponseDataMap(
        status: false,
        message: 'Email dan password salah',
      );
      return response;
    }
  } else {
    ResponseDataMap response = ResponseDataMap(
      status: false,
      message: "gagal login user dengan code error ${register.statusCode}",
    );
    return response;
  }
}

}
