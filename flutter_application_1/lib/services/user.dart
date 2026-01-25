import 'dart:convert';
import '../models/response_data_map.dart';
import 'url.dart' as url;
import 'package:http/http.dart' as http;
import '../models/user_login.dart';

class UserService {
  Future<ResponseDataMap> registerUser(data) async {
    var uri = Uri.parse(url.baseUrl + "/auth/register");
    var register = await http.post(uri, body: data);
    if (register.statusCode == 200) {
      var responseData = jsonDecode(register.body);
      if (responseData["status"] == true) {
        ResponseDataMap response = ResponseDataMap(
          status: true,
          message: "Sukses menambah user",
          data: responseData,
        );
        return response;
      } else {
        var message = '';
        for (String key in responseData["message"].keys) {
          message += responseData["message"][key][0].toString() + '\n';
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

  Future<ResponseDataMap> loginUser(data) async {
    var uri = Uri.parse(url.baseUrl + "/login");
    var register = await http.post(uri, body: data);
    if (register.statusCode == 200) {
      var responseData = jsonDecode(register.body);
      if (responseData["status"] == true) {
        UserLogin userLogin = UserLogin(
          status: responseData["status"],
          token: responseData["authorisation"]["token"],
          message: responseData["message"],
          id: responseData["data"]["id"],
          nama_user: responseData["data"]["name"],
          email: responseData["data"]["email"],
          role: responseData["data"]["role"],
        );
        await userLogin.prefs();
        ResponseDataMap response = ResponseDataMap(
          status: true,
          message: "Sukses login user",
          data: responseData,
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
