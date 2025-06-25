import 'package:flutter/material.dart';
class FavoriteTile extends StatefulWidget {
  const FavoriteTile({super.key});

  @override
  State<FavoriteTile> createState() => _FavoriteTileState();
}

class _FavoriteTileState extends State<FavoriteTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Verse No."),
        Text(
          "shlokaaa",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
