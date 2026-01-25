import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/user.dart';
import 'package:flutter_application_1/widgets/alert.dart';


class register_user_view extends StatefulWidget {
  const register_user_view({super.key});

  @override
  State<register_user_view> createState() => _register_user_view();
}

class _register_user_view extends State<register_user_view> {
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  List<String> roleChoice = ["admin","owner"];
  String? role;

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// AppBar
      appBar: AppBar(
        title: const Text("TOKO ONLINE"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),

              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Masukan Nama"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: name,
                      decoration: inputDecoration("Nama"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Nama wajib diisi";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    const Text("Masukan Email"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: email,
                      decoration: inputDecoration("Email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email wajib diisi";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    const Text("Masukan Password"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: inputDecoration("Password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password wajib diisi";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    const Text("Pilih Role"),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: role,
                      decoration: inputDecoration("Role"),
                      items: roleChoice.map((r) {
                        return DropdownMenuItem(
                          value: r,
                          child: Text(r),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          role = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Role wajib dipilih";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            var data = {
                              'name': name.text,
                              'email': email.text,
                              'password': password.text,
                              'role': role,
                            };
                            UserService userService = UserService();
                            var response = await userService.registerUser(data);
                            AlertMessage alert = AlertMessage();
                            alert.showAlert(context, response.message, response.status);
                            Navigator.pushNamed(context, '/login');
                          }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 242, 247, 242),
                          ),
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
}