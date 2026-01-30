import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/BottomNav.dart';
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
    var user = await userLogin.getUserLogin();
    if (user.status != false) {
      setState(() {
        nama = user.nama_user;
        role = user.role;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Dashboard"),
        elevation: 1,
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartu profil
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.blue[100],
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.blue[800],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Halo,",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            nama ?? 'User',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              role ?? 'Role',
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w500,
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
            
            const SizedBox(height: 25),
            
            // Quick menu
            const Text(
              "Menu Cepat",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 15),
            
            // Grid menu
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.5,
              children: [
                _buildMenuCard(
                  icon: Icons.task,
                  title: "Tugas",
                  color: Colors.blue,
                ),
                _buildMenuCard(
                  icon: Icons.message,
                  title: "Pesan",
                  color: Colors.green,
                ),
                _buildMenuCard(
                  icon: Icons.notifications,
                  title: "Notifikasi",
                  color: Colors.orange,
                ),
                _buildMenuCard(
                  icon: Icons.settings,
                  title: "Pengaturan",
                  color: Colors.purple,
                ),
              ],
            ),
            
            const SizedBox(height: 25),
            
            // Logout button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.popAndPushNamed(context, '/login'),
                icon: const Icon(Icons.logout),
                label: const Text("Keluar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(0),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}