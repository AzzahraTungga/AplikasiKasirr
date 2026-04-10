import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart'; // Untuk kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/response_data_map.dart';
import 'package:flutter_application_1/models/toko_model.dart';
import 'package:flutter_application_1/models/response_data_list.dart';
import 'package:flutter_application_1/models/user_login.dart';
import 'package:flutter_application_1/services/url.dart' as url;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Pastikan sudah install: flutter pub add http_parser

class tokoService {
  
  // 1. FUNGSI AMBIL DATA (GET)
  Future getToko() async {
    UserLogin userLogin = UserLogin();
    var user = await userLogin.getUserLogin();
    if (user.status == false) {
      return ResponseDataList(status: false, message: 'Anda belum login / token invalid');
    }

    var uri = Uri.parse("${url.baseUrl}/admin/getbarang");
    Map<String, String> headers = {"Authorization": 'Bearer ${user.token}'};
    
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data["status"] == true) {
        List items = data["data"].map((r) => TokoModel.fromJson(r)).toList();
        return ResponseDataList(status: true, message: 'Success load data', data: items);
      }
      return ResponseDataList(status: false, message: 'Failed load data');
    }
    return ResponseDataList(status: false, message: "Error code: ${res.statusCode}");
  }

  // 2. FUNGSI SIMPAN & UPDATE DATA (POST)
  Future insertToko(Map<String, String> data, File? selectedImage, int id) async {
    var user = await UserLogin().getUserLogin();
    if (user.status == false) {
      return ResponseDataMap(status: false, message: 'Anda belum login');
    }

    var uri = id == 0
        ? Uri.parse("${url.baseUrl}/admin/insertmovie")
        : Uri.parse("${url.baseUrl}/admin/updatemovie/$id");

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      "Authorization": 'Bearer ${user.token}',
    });

    request.fields.addAll({
      'nama_barang': data['nama_barang'] ?? '',
      'deskripsi': data['deskripsi'] ?? '',
      'harga': data['harga'] ?? '',
      'toko': data['toko'] ?? '',
    });

    if (selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'posterpath',
        selectedImage.path,
      ));
    }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var result = json.decode(response.body);

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        return ResponseDataMap(
          status: result["status"] == true,
          message: result["message"] ?? (result["status"] == true ? 'Success simpan data' : 'Failed simpan data'),
        );
      }
      return ResponseDataMap(status: false, message: "Server error: ${response.statusCode}");
    } catch (e) {
      return ResponseDataMap(status: false, message: "Kesalahan Koneksi: $e");
    }
  }

  // 3. FUNGSI HAPUS DATA (DELETE)
  Future hapusToko(BuildContext context, id) async {
    var user = await UserLogin().getUserLogin();
    if (user.status == false) {
      return ResponseDataList(status: false, message: 'Anda belum login');
    }

    var uri = Uri.parse("${url.baseUrl}/admin/hapusmovie/$id");
    Map<String, String> headers = {
      "Authorization": 'Bearer ${user.token}',
      "Content-type": "application/json",
    };

    var res = await http.delete(uri, headers: headers);

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      return ResponseDataList(status: data["status"], message: data["status"] ? 'Success delete' : 'Failed delete');
    }
    return ResponseDataList(status: false, message: "Error code: ${res.statusCode}");
  }
}