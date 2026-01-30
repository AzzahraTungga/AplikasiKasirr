import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/BottomNav.dart';

class Dataproduk extends StatefulWidget {
  const Dataproduk({super.key});

  @override
  State<Dataproduk> createState() => _DataprodukState();
}

class _DataprodukState extends State<Dataproduk> {
  // Data dummy khusus buku
  final List<Map<String, dynamic>> riwayatBuku = [
    {
      "penerbit": "Gramedia Pustaka Utama",
      "judul": "Laut Bercerita",
      "penulis": "Leila S. Chudori",
      "qty": 1,
      "harga": 115000,
      "total": 125000, // Termasuk ongkir misal
      "status": "Dikirim",
      "cover": Icons.menu_book_rounded,
    },
    {
      "penerbit": "Bentang Pustaka",
      "judul": "Laskar Pelangi",
      "penulis": "Andrea Hirata",
      "qty": 2,
      "harga": 89000,
      "total": 178000,
      "status": "Selesai",
      "cover": Icons.library_books_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // Biru abu-abu sangat muda
      appBar: AppBar(
        title: const Text("Riwayat Literasi", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[900], // Biru navy gelap khas toko buku
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Filter Status - Nuansa Biru
          Container(
            height: 60,
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ["Semua", "Menunggu Pembayaran", "Diproses", "Dikirim", "Selesai"]
                  .map((status) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Chip(
                          backgroundColor: status == "Selesai" ? Colors.blue[100] : Colors.grey[100],
                          label: Text(status, 
                            style: TextStyle(
                              color: status == "Selesai" ? Colors.blue[900] : Colors.black54,
                              fontSize: 12
                            )
                          ),
                          side: BorderSide.none,
                        ),
                      ))
                  .toList(),
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: riwayatBuku.length,
              itemBuilder: (context, index) {
                final buku = riwayatBuku[index];
                return _buildBookOrderCard(buku);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }

  Widget _buildBookOrderCard(Map<String, dynamic> buku) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Baris Atas: Penerbit & Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.storefront, size: 18, color: Colors.blue[700]),
                    const SizedBox(width: 8),
                    Text(buku['penerbit'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
                Text(
                  buku['status'],
                  style: TextStyle(
                    color: buku['status'] == "Selesai" ? Colors.green : Colors.blue[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Divider(height: 25),
            
            // Baris Tengah: Info Buku
            Row(
              children: [
                Container(
                  width: 60,
                  height: 85,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(buku['cover'], color: Colors.blue[300], size: 40),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(buku['judul'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text("Penulis: ${buku['penulis']}", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("x${buku['qty']}", style: const TextStyle(color: Colors.black54)),
                          Text("Rp ${buku['harga']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 15),
            // Baris Bawah: Total & Aksi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total Bayar", style: TextStyle(color: Colors.grey, fontSize: 11)),
                    Text("Rp ${buku['total']}", 
                      style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 16)
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (buku['status'] == "Dikirim")
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("Lacak Kurir", style: TextStyle(color: Colors.white)),
                      ),
                    if (buku['status'] == "Selesai")
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.blue[700]!),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text("Beri Rating", style: TextStyle(color: Colors.blue[700])),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}