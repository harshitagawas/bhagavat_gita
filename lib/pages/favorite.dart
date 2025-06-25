import "package:bhagavad_gita/components/appbar.dart";
import "package:bhagavad_gita/components/favorite_tile.dart";
import "package:flutter/material.dart";

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Bar(child:
    FavoriteTile()
    );
  }
}
