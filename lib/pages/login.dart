import 'package:bhagavad_gita/pages/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/auth_service.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bhagavat Gita",
                style: TextStyle(fontSize: 32, color: Colors.amber),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter phone number",
                ),
                controller: controller,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  String phone = '+91${controller.text.trim()}';
                  print("[DEBUG] 📲 Sending OTP to $phone");

                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: phone,
                    verificationCompleted: (PhoneAuthCredential credential) {
                      print("[DEBUG] ✅ Auto-retrieval completed. Credential: $credential");
                    },
                    verificationFailed: (FirebaseAuthException ex) {
                      print("[DEBUG] ❌ Verification failed: ${ex.code} - ${ex.message}");
                      print("[DEBUG] Stacktrace: ${ex.stackTrace}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Verification failed: ${ex.message}')),
                      );
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      print("[DEBUG] 📩 OTP sent. Verification ID: $verificationId, ResendToken: $resendToken");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpScreen(verificationId: verificationId),
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {
                      print("[DEBUG] ⏰ Auto-retrieval timeout. Verification ID: $verificationId");
                    },
                  );
                  print("[DEBUG] verifyPhoneNumber call completed");
                },
                child: Text("Send OTP"),
              ),
              Divider(height: 50, thickness: 2),
              ElevatedButton(
                onPressed: () async {
                  print("🔁 Google Sign-In started...");
                  final user = await AuthService.signInWithGoogle();
                  print("👤 Signed-in user: $user");

                  if (user != null) {
                    print("➡️ Navigating to Home...");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const Home()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sign-in cancelled')),
                    );
                  }
                },
                child: Text("Sign in with Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
