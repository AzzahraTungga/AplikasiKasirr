import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/toko.dart';
import 'package:flutter_application_1/services/url.dart' as url;
import 'package:flutter_application_1/views/tambah.dart';
import 'package:flutter_application_1/widgets/BottomNav.dart';
import 'package:flutter_application_1/models/response_data_list.dart';

class TokoView extends StatefulWidget {
  const TokoView({super.key});

  @override
  State<TokoView> createState() => _TokoViewState();
}

class _TokoViewState extends State<TokoView> {
  tokoService toko = tokoService();
  List? produk;
  List action = ["Update", "Delete"];

  getToko() async {
    ResponseDataList getData = await toko.getToko();
    setState(() {
      produk = getData.data;
    });
  }

  @override
  void initState() {
    super.initState();
    getToko();
  }

  Future<bool?> confirmDelete(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Yakin ingin menghapus produk ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Product", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Tambah(title: "Tambah Product", item: null)),
              ).then((value) => getToko()); // Refresh setelah tambah
            },
            icon: const Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2171D3), Color(0xFF5391E4), Color(0xFF90C2FF)],
          ),
        ),
        child: produk != null
            ? ListView.builder(
                padding: const EdgeInsets.only(top: 120, left: 15, right: 15, bottom: 20),
                itemCount: produk!.length,
                itemBuilder: (context, index) {
                  // ✅ LOGIKA URL GAMBAR YANG BENAR
                  String imageUrl = produk![index].image ?? "";
                  String fullUrl = imageUrl.startsWith("http") 
                      ? imageUrl 
                      : "${url.baseUrlTanpaAPi}/storage/images/$imageUrl";

                  return Card(
                    color: Colors.white.withOpacity(0.95),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        // ✅ PERBAIKAN leading: Menggunakan Image.network dengan errorBuilder
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            fullUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            // ✅ Mencegah Error "No host specified" menghancurkan aplikasi
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                        title: Text(
                          produk![index].nama_barang ?? "Tanpa Nama",
                          style: const TextStyle(color: Color(0xFF1A4D8F), fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          produk![index].deskripsi ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: PopupMenuButton(
                          onSelected: (value) async {
                            if (value == "Update") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Tambah(title: "Update Product", item: produk![index]),
                                ),
                              ).then((value) => getToko());
                            } else if (value == "Delete") {
                              bool? confirm = await confirmDelete(context);
                              if (confirm == true) {
                                var res = await toko.hapusToko(context, produk![index].id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(res.message)),
                                );
                                if (res.status == true) getToko();
                              }
                            }
                          },
                          itemBuilder: (context) => action.map((r) => PopupMenuItem(value: r, child: Text(r))).toList(),
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }
}