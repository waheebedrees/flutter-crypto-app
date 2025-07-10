import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart';
import '../handler/authn.dart';
import '../utils/style.dart';
import 'login_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});
  @override
  CreateAccountScreenState createState() => CreateAccountScreenState();
}
class CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;
  List<bool> _isPasswordVisible = [false, false];
  String? _errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _createAccount() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = "Please fill all fields.";
        _isLoading = false;
      });
      return;
    }

    if (!isValidEmail(email)) {
      setState(() {
        _errorMessage = "Invalid email format.";
        _isLoading = false;
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = "Passwords do not match.";
        _isLoading = false;
      });
      return;
    }

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (!mounted) return;

      // Create a default portfolio for the user
      await _createDefaultPortfolio(userCredential.user!.uid);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = getCustomErrorMessage(e);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _createDefaultPortfolio(String userId) async {
    // Define the default portfolio
    final portfolioData = {
      'coins': [
        {'type': 'Bitcoin', 'amount': 0.0},
        {'type': 'Ethereum', 'amount': 0.0},
        {'type': 'Litecoin', 'amount': 0.0},
      ],
    };

    // Save the portfolio to Firestore under the user's document
    await _firestore
        .collection('users')
        .doc(userId)
        .set({'portfolio': portfolioData});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              style: TextStyle(color: AppColors.whiteColor),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: AppColors.whiteColor),
                prefixIcon: Icon(Icons.email, color: AppColors.whiteColor),
              ),
            ),
            const SizedBox(height: 20),
            PasswordField(
              controller: passwordController,
              isPasswordVisible: _isPasswordVisible[0],
              toggleVisibility: () {
                setState(() {
                  _isPasswordVisible[0] = !_isPasswordVisible[0];
                });
              },
              label: "Password",
            ),
            const SizedBox(height: 20),
            PasswordField(
              controller: confirmPasswordController,
              isPasswordVisible: _isPasswordVisible[1],
              toggleVisibility: () {
                setState(() {
                  _isPasswordVisible[1] = !_isPasswordVisible[1];
                });
              },
              label: "Confirm Password",
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _createAccount,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.contentColorBlack,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Create Account",
                      style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              child: const Text(
                "Already have an account? Login",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPasswordVisible;
  final VoidCallback toggleVisibility;
  final String label;

  const PasswordField({
    Key? key,
    required this.controller,
    required this.isPasswordVisible,
    required this.toggleVisibility,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !isPasswordVisible,
      controller: controller,
      style: TextStyle(color: AppColors.whiteColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.whiteColor),
        prefixIcon: Icon(Icons.lock, color: AppColors.whiteColor),
        suffixIcon: IconButton(
          onPressed: toggleVisibility,
          icon:
              Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
