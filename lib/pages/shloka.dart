import 'package:bhagavad_gita/components/appbar.dart';
import 'package:bhagavad_gita/components/shloka_index.dart';
import 'package:flutter/material.dart';
class Shloka extends StatefulWidget {
  const Shloka({super.key});

  @override
  State<Shloka> createState() => _ShlokaState();
}

class _ShlokaState extends State<Shloka> {
  @override
  Widget build(BuildContext context) {
    return Bar(
    child: ShlokaIndex(),
    );
  }
}

