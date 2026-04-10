import 'dart:io';
import 'dart:typed_data'; // Untuk mengolah gambar di Web
import 'package:flutter/foundation.dart'; // Untuk cek kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/toko_model.dart';
import 'package:flutter_application_1/services/toko.dart';
import 'package:flutter_application_1/widgets/alert.dart';
import 'package:image_picker/image_picker.dart';

class Tambah extends StatefulWidget {
  final String title;
  final TokoModel? item;

  const Tambah({super.key, required this.title, this.item});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  tokoService toko = tokoService();
  final formkey = GlobalKey<FormState>();
  
  TextEditingController namaBarang = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController stok = TextEditingController();
  
  File? selectedImage; // Digunakan untuk Mobile
  Uint8List? webImage; // Digunakan untuk tampilan di Web
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Jika sedang edit data (item tidak null), isi field dengan data lama
    if (widget.item != null) {
      namaBarang.text = widget.item!.nama_barang ?? "";
      deskripsi.text = widget.item!.deskripsi ?? "";
      harga.text = widget.item!.harga?.toString() ?? "";
      stok.text = widget.item!.toko?.toString() ?? "";
    }
  }

  // Fungsi mengambil gambar yang support Web & Mobile
  Future getImage() async {
    setState(() => isLoading = true);
    
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      var f = await image.readAsBytes();
      setState(() {
        webImage = f;
        if (!kIsWeb) {
          selectedImage = File(image.path); // Simpan path untuk dikirim ke service di Mobile
        }
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  // Desain Input Field yang Konsisten
  InputDecoration _inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blue[700]),
      filled: true,
      fillColor: Colors.blue[50]!.withOpacity(0.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.blue[200]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.blue[100]!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2196F3), Color(0xFFBBDEFB)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Text(
                "Detail Produk",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 10))
                  ],
                ),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: namaBarang,
                        decoration: _inputStyle("Nama Barang", Icons.shopping_bag),
                        validator: (v) => v!.isEmpty ? "Nama barang wajib diisi" : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: deskripsi,
                        decoration: _inputStyle("Deskripsi", Icons.description),
                        maxLines: 2,
                        validator: (v) => v!.isEmpty ? "Deskripsi wajib diisi" : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: harga,
                        keyboardType: TextInputType.number,
                        decoration: _inputStyle("Harga", Icons.payments),
                        validator: (v) => v!.isEmpty ? "Harga harus diisi" : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: stok,
                        keyboardType: TextInputType.number,
                        decoration: _inputStyle("Stok", Icons.inventory),
                        validator: (v) => v!.isEmpty ? "Stok harus diisi" : null,
                      ),
                      const SizedBox(height: 20),
                      
                      // Area Tampilan Gambar
                      if (isLoading)
                        const CircularProgressIndicator()
                      else if (webImage != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.memory(webImage!, height: 150, width: double.infinity, fit: BoxFit.cover),
                        )
                      else if (widget.item != null)
                        const Text("Gambar tersimpan di server", style: TextStyle(fontSize: 12))
                      else
                        const Text("Belum ada gambar dipilih", style: TextStyle(color: Colors.grey)),

                      TextButton.icon(
                        onPressed: getImage,
                        icon: const Icon(Icons.add_a_photo),
                        label: const Text("Ambil Gambar"),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Tombol Simpan
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D47A1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              var data = {
                                "nama_barang": namaBarang.text,
                                "harga": harga.text,
                                "deskripsi": deskripsi.text,
                                "toko": stok.text,
                              };
                              
                              int idBarang = widget.item?.id ?? 0;
                              
                              // Memanggil service untuk simpan ke database
                              var result = await toko.insertToko(data, selectedImage, idBarang);

                              if (result.status == true) {
                                AlertMessage().showAlert(context, "Berhasil Menyimpan", true);
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(context, '/movie');
                              } else {
                                AlertMessage().showAlert(context, "Gagal: ${result.message}", false);
                              }
                            }
                          },
                          child: const Text('SIMPAN PRODUK', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}