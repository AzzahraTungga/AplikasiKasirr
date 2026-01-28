import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/user.dart';
import 'package:flutter_application_1/widgets/alert.dart';
import 'package:flutter_application_1/views/loginViews.dart';
class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});
  @override
  State<RegisterUserView> createState() => _register_user_view();
}

class _register_user_view extends State<RegisterUserView> {
  UserService userService = UserService();
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  List roleChoice = ["admin", "user"];
  String? role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade900, Colors.blue.shade400, Colors.blue.shade50],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text(
                    "HI NIGHT READERS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w900, 
                      color: Colors.white,
                      letterSpacing: 2.5,
                      shadows: [
                        Shadow(color: Colors.black38, offset: Offset(3, 3), blurRadius: 6)
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 25,
                          spreadRadius: 5,
                        )
                      ],
                    ),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Create Account",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                              const SizedBox(height: 30),

                              _buildTextField(
                                controller: name,
                                label: "Name",
                                icon: Icons.person_outline,
                                validator: (value) => (value == null || value.isEmpty) ? 'Enter your name' : null,
                              ),
                              const SizedBox(height: 18),

                              _buildTextField(
                                controller: email,
                                label: "Email Address",
                                icon: Icons.email_outlined,
                                validator: (value) => (value == null || value.isEmpty) ? 'Enter your email' : null,
                              ),
                              const SizedBox(height: 18),

                              _buildTextField(
                                controller: password,
                                label: "Password",
                                icon: Icons.lock_outline,
                                isPassword: true,
                                validator: (value) => (value == null || value.isEmpty) ? 'Enter your password' : null,
                              ),
                              const SizedBox(height: 18),

                              DropdownButtonFormField<String>(
                                value: role,
                                decoration: _inputDecoration("Select Role", Icons.shield_outlined),
                                icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                                items: roleChoice.map((r) {
                                  return DropdownMenuItem<String>(value: r, child: Text(r));
                                }).toList(),
                                onChanged: (newValue) => setState(() => role = newValue),
                                validator: (value) => (value == null) ? 'Please select a role' : null,
                              ),
                              const SizedBox(height: 35),

                              
                              Container(
                                width: double.infinity,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [Colors.blue.shade700, Colors.blue.shade900],
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      var data = {
                                        "name": name.text,
                                        "email": email.text,
                                        "password": password.text,
                                        "role": role,
                                      };
                                      
                                      var response = await userService.registerUser(data);
                                      
                                      if (response.status) {

                                        AlertMessage().showAlert(context, response.message, true);
                                        
                                      
                                        name.clear();
                                        email.clear();
                                        password.clear();
                                        setState(() => role = null);

                                        
                                        Future.delayed(const Duration(seconds: 2), () {
                                          if (mounted) {
                                            Navigator.pushReplacementNamed(context, '/login');
                                          }
                                        });
                                      } else {

                                        AlertMessage().showAlert(context, response.message, false);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  ),
                                  child: const Text(
                                    "REGISTER",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                  
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have an account? ", style: TextStyle(color: Colors.grey)),
                                  GestureDetector(
                                    onTap: () => Navigator.pushNamed(context, '/login'),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.blue.shade800,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: _inputDecoration(label, icon),
      validator: validator,
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.blue.shade700, fontSize: 14),
      prefixIcon: Icon(icon, color: Colors.blue.shade700),
      filled: true,
      fillColor: Colors.blue.shade50.withOpacity(0.3),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.blue.shade100),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }
}