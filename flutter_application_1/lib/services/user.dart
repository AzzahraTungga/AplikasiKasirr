import 'dart:convert';
import '../models/response_data_map.dart';
import 'url.dart' as url;
import 'package:http/http.dart' as http;
import '../models/user_login.dart';

class UserService {
  Future<ResponseDataMap> registerUser(data) async {
    try {
      var uri = Uri.parse(url.baseUrl + "/auth/register");
      var response = await http.post(uri, body: data).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw Exception('Koneksi timeout'),
      );
      
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData["status"] == true) {
          return ResponseDataMap(
            status: true,
            message: "Registrasi berhasil",
            data: responseData,
          );
        } else {
          var message = '';
          if (responseData["message"] is Map) {
            for (String key in responseData["message"].keys) {
              message += responseData["message"][key][0].toString() + '\n';
            }
          } else {
            message = responseData["message"].toString();
          }
          return ResponseDataMap(
            status: false,
            message: message,
          );
        }
      } else {
        return ResponseDataMap(
          status: false,
          message: "Registrasi gagal - Error ${response.statusCode}",
        );
      }
    } catch (e) {
      return ResponseDataMap(
        status: false,
        message: "Error: ${e.toString()}",
      );
    }
  }

  Future<ResponseDataMap> loginUser(data) async {
    try {
      var uri = Uri.parse(url.baseUrl + "/auth/login");
      var response = await http.post(uri, body: data).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw Exception('Koneksi timeout'),
      );
      
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData["status"] == true) {
          UserLogin userLogin = UserLogin(
            status: responseData["status"],
            token: responseData["authorisation"]["token"],
            message: responseData["message"],
            id: responseData["user"]["id"],
            nama_user: responseData["user"]["name"],
            email: responseData["user"]["email"],
            role: responseData["user"]["role"],
          );
          await userLogin.prefs();
          return ResponseDataMap(
            status: true,
            message: "Login berhasil",
            data: responseData,
          );
        } else {
          return ResponseDataMap(
            status: false,
            message: "Email atau password salah",
          );
        }
      } else {
        return ResponseDataMap(
          status: false,
          message: "Login gagal - Error ${response.statusCode}",
        );
      }
    } catch (e) {
      return ResponseDataMap(
        status: false,
        message: "Error: ${e.toString()}",
      );
    }
  }
}
