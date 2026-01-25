import 'package:flutter/material.dart';
import '../models/user_login.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  UserLogin userLogin = UserLogin();
  String? nama;
  String? role;

  getUserLogin() async {
    try {
      var user = await userLogin.getUserLogin();
      if (user.status != false) {
        if (mounted) {
          setState(() {
            nama = user.nama_user;
            role = user.role;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        print('Error loading user: $e');
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLogin();
  }

  // Fungsi Logout dengan Konfirmasi
  Future<void> _handleLogout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Log Out'),
          content: const Text('Apakah anda yakin ingin menghapus session dan keluar?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Ya, Keluar', style: TextStyle(color: Colors.red)),
              onPressed: () async {
            
                await userLogin.logout(); 

                if (!mounted) return;
                
                Navigator.of(context).pop(); 

                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _handleLogout, 
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: nama == null 
          ? const CircularProgressIndicator() 
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, size: 80, color: Colors.blue),
                const SizedBox(height: 10),
                Text(
                  "Selamat Datang $nama",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("Role Anda: $role", style: TextStyle(color: Colors.grey[600])),
              ],
            ),
      ),
    );
  }
}