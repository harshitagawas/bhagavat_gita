import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../pages/login.dart';
import '../providers/language_provider.dart';


class Bar extends StatelessWidget {
  final Widget child;
  const Bar({super.key, required this.child});

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final currentLang = langProvider.langCode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("BHAGAVAT GITA"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _signOut(context),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: const Icon(Icons.translate, color: Colors.white),
                value: currentLang,
                dropdownColor: const Color(0xFFE88D2C),
                items: const [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text("English", style: TextStyle(color: Colors.white)),
                  ),
                  DropdownMenuItem(
                    value: 'hi',
                    child: Text("हिन्दी", style: TextStyle(color: Colors.white)),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    langProvider.changeLang(value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      body: child,
      backgroundColor: const Color(0xFFFFF8F0),
    );
  }
}
