import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/BottomNav.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Riwayat Pembelian Buku"),
        elevation: 1,
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Filter transaksi
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Filter Section
          _buildFilterSection(),
          const SizedBox(height: 16),
          
          // Buku 1 - Pemrograman
          _buildBookTransaction(
            bookTitle: "Flutter Programming Guide",
            author: "John Doe",
            category: "Pemrograman",
            storeName: "TechBook Store",
            status: "Selesai",
            price: 125000,
            quantity: 1,
            date: "15 Jan 2024",
            invoiceNo: "BOOK/2024/00125",
          ),
          
          const SizedBox(height: 16),
          
          // Buku 2 - Novel
          _buildBookTransaction(
            bookTitle: "Laskar Pelangi",
            author: "Andrea Hirata",
            category: "Novel",
            storeName: "Literacy Bookstore",
            status: "Selesai",
            price: 85000,
            quantity: 2,
            date: "12 Jan 2024",
            invoiceNo: "BOOK/2024/00123",
          ),
          
          const SizedBox(height: 16),
          
          // Buku 3 - Bisnis
          _buildBookTransaction(
            bookTitle: "Rich Dad Poor Dad",
            author: "Robert Kiyosaki",
            category: "Bisnis & Ekonomi",
            storeName: "Business Book ID",
            status: "Diproses",
            price: 95000,
            quantity: 1,
            date: "18 Jan 2024",
            invoiceNo: "BOOK/2024/00130",
          ),
          
          const SizedBox(height: 16),
          
          // Buku 4 - Fiksi
          _buildBookTransaction(
            bookTitle: "Bumi Manusia",
            author: "Pramoedya Ananta Toer",
            category: "Fiksi Sejarah",
            storeName: "Classic Books",
            status: "Dikirim",
            price: 110000,
            quantity: 1,
            date: "10 Jan 2024",
            invoiceNo: "BOOK/2024/00120",
          ),
          
          const SizedBox(height: 16),
          
          // Buku 5 - Sains
          _buildBookTransaction(
            bookTitle: "Sapiens: Riwayat Singkat Umat Manusia",
            author: "Yuval Noah Harari",
            category: "Sains Populer",
            storeName: "Science Bookstore",
            status: "Selesai",
            price: 135000,
            quantity: 1,
            date: "05 Jan 2024",
            invoiceNo: "BOOK/2024/00115",
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.filter_alt_outlined, color: Colors.blue[700], size: 20),
              const SizedBox(width: 8),
              const Text(
                "Filter:",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            children: [
              Chip(
                label: const Text("Semua"),
                backgroundColor: Colors.blue[50],
                side: BorderSide(color: Colors.blue[300]!),
              ),
              Chip(
                label: const Text("Selesai"),
                backgroundColor: Colors.green[50],
                side: BorderSide(color: Colors.green[300]!),
              ),
              Chip(
                label: const Text("Diproses"),
                backgroundColor: Colors.orange[50],
                side: BorderSide(color: Colors.orange[300]!),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookTransaction({
    required String bookTitle,
    required String author,
    required String category,
    required String storeName,
    required String status,
    required int price,
    required int quantity,
    required String date,
    required String invoiceNo,
  }) {
    // Color berdasarkan status
    Color statusColor;
    Color statusBgColor;
    
    switch (status) {
      case "Selesai":
        statusColor = Colors.green[800]!;
        statusBgColor = Colors.green[50]!;
        break;
      case "Diproses":
        statusColor = Colors.orange[800]!;
        statusBgColor = Colors.orange[50]!;
        break;
      case "Dikirim":
        statusColor = Colors.blue[800]!;
        statusBgColor = Colors.blue[50]!;
        break;
      default:
        statusColor = Colors.grey[800]!;
        statusBgColor = Colors.grey[50]!;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.blue[700]!,
              width: 4,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header - Invoice & Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.receipt_long, size: 16, color: Colors.blue[700]),
                          const SizedBox(width: 6),
                          Text(
                            invoiceNo,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 6),
                          Text(
                            date,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              Divider(color: Colors.grey[300], height: 1),
              const SizedBox(height: 12),
              
              // Info Toko
              Row(
                children: [
                  Icon(Icons.store_mall_directory, size: 16, color: Colors.blue[700]),
                  const SizedBox(width: 8),
                  Text(
                    storeName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[800],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Detail Buku
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover Buku
                  Container(
                    width: 70,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _getBookColor(category),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getBookIcon(category),
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.split(" ").first,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Info Buku
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 4),
                        
                        Row(
                          children: [
                            Icon(Icons.person_outline, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              "Penulis: $author",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 4),
                        
                        Row(
                          children: [
                            Icon(Icons.category_outlined, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              "Kategori: $category",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Harga dan Quantity
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Harga Satuan:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    "Rp${_formatPrice(price)}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Jumlah:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.blue[300]!),
                                    ),
                                    child: Text(
                                      "x$quantity",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Total Harga
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue[200]!),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "TOTAL PEMBAYARAN:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Rp${_formatPrice(price * quantity)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Tombol Aksi
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Lihat detail buku
                      },
                      icon: const Icon(Icons.remove_red_eye_outlined, size: 18),
                      label: const Text("Detail Buku"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        side: BorderSide(color: Colors.blue.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Beli lagi
                      },
                      icon: const Icon(Icons.shopping_cart_checkout, size: 18),
                      label: const Text("Beli Lagi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Footer Info
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Buku dapat dikembalikan dalam 14 hari jika terdapat cacat/cetak",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBookColor(String category) {
    if (category.contains("Pemrograman")) return Colors.blue[700]!;
    if (category.contains("Novel")) return Colors.purple[700]!;
    if (category.contains("Bisnis")) return Colors.green[700]!;
    if (category.contains("Fiksi")) return Colors.orange[700]!;
    if (category.contains("Sains")) return Colors.teal[700]!;
    return Colors.blue[600]!;
  }

  IconData _getBookIcon(String category) {
    if (category.contains("Pemrograman")) return Icons.code;
    if (category.contains("Novel")) return Icons.menu_book;
    if (category.contains("Bisnis")) return Icons.business_center;
    if (category.contains("Fiksi")) return Icons.auto_stories;
    if (category.contains("Sains")) return Icons.science;
    return Icons.book;
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}