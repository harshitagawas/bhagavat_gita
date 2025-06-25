import 'package:bhagavad_gita/components/appbar.dart';
import 'package:bhagavad_gita/components/chap_sum_tile.dart';
import 'package:flutter/material.dart';

class ChapSum extends StatefulWidget {
  const ChapSum({super.key});

  @override
  State<ChapSum> createState() => _ChapSumState();
}

class _ChapSumState extends State<ChapSum> {
  @override
  Widget build(BuildContext context) {
    return Bar(
      child: ChapSumTile(),
    );
  }
}
