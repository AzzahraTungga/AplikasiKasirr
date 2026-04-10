import 'package:flutter_application_1/services/url.dart' as url;


class TokoModel {
  int? id;
  String? nama_barang;
  String? deskripsi;
  int? toko;
  int? harga;
  String? image;
  TokoModel({
    required this.id,
    required this.nama_barang,
    this.deskripsi,
    this.toko,
    this.harga,
    this.image,
  });
  TokoModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"];
    nama_barang = parsedJson["nama_barang"];
    deskripsi = parsedJson["deskripsi"];
    toko = parsedJson["toko"];
    harga = parsedJson["harga"];
    image = "${url.baseUrlTanpaAPi}/${parsedJson["image"]}";
  }
}
