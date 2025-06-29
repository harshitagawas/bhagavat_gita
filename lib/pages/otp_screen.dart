import 'dart:developer';
import 'package:bhagavad_gita/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Enter OTP"),
                onChanged: (val) {
                  print('[DEBUG] OTP input changed: ' + val);
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  print("[DEBUG] 🔢 Verifying OTP...");
                  try {
                    final smsCode = otpController.text.trim();
                    print("[DEBUG] 🔐 Creating PhoneAuthCredential with code: $smsCode and verificationId: ${widget.verificationId}");

                    PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: smsCode,
                    );

                    print("[DEBUG] Attempting signInWithCredential...");
                    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                      print("[DEBUG] ✅ OTP verified, user signed in: [value.user?.uid]");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    });
                    print("[DEBUG] signInWithCredential completed");
                  } catch (ex, stack) {
                    log("[DEBUG] ❌ OTP verification failed: $ex");
                    print("[DEBUG] ❌ OTP verification failed: $ex");
                    print("[DEBUG] Stacktrace: $stack");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Verification failed: $ex")),
                    );
                  }
                },
                child: const Text("Verify OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
