import 'package:flutter/material.dart';
import 'dashboard.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showPass = true;

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
                  const Text("HI NIGHT READERS",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2.5),
                  ),
                  const SizedBox(height: 40),
                  _buildCardForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardForm() {
    return Container(
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 25, spreadRadius: 5)]),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text("Login to Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.blue.shade900)),
                const SizedBox(height: 30),
                _inputField(email, "Email Address", Icons.email_outlined, false),
                const SizedBox(height: 18),
                _inputField(password, "Password", Icons.lock_outline, showPass, isPass: true),
                const SizedBox(height: 35),
                _buildButton(),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/register'),
                      child: Text("Register", style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController ctrl, String label, IconData icon, bool obscure, {bool isPass = false}) {
    return TextFormField(
      controller: ctrl,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue.shade700),
        suffixIcon: isPass ? IconButton(icon: Icon(obscure ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => showPass = !showPass)) : null,
        filled: true,
        fillColor: Colors.blue.shade50.withOpacity(0.3),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
      validator: (v) => (v == null || v.isEmpty) ? 'Field required' : null,
    );
  }

  Widget _buildButton() {
    return Container(
      width: double.infinity, height: 55,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), gradient: LinearGradient(colors: [Colors.blue.shade700, Colors.blue.shade900])),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
        onPressed: () {
          if (formKey.currentState!.validate()) Navigator.pushReplacementNamed(context, '/dashboard');
        },
        child: const Text("LOGIN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}