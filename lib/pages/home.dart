import 'package:bhagavad_gita/components/appbar.dart';
import 'package:bhagavad_gita/components/main_choice.dart';
import 'package:bhagavad_gita/pages/chap_sum.dart';
import 'package:bhagavad_gita/pages/favorite.dart';
import 'package:bhagavad_gita/pages/shloka.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Bar(child:

    Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center Row items
            children: [
              Choice(icon: Icons.book,
                label: "Chapter Summary",
                border: 1,
                route: ChapSum(),),
              const SizedBox(width: 20),
              Choice(icon: Icons.request_page_rounded,
                label: "Shlokas",
                border: 2,
                route: Shloka(),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Choice(icon: Icons.favorite,
                label: "Favorites",
                border: 2,
                route: FavoritePage(),),
              const SizedBox(width: 20),
              Choice(icon: Icons.music_note_rounded,
                label: "Your Playlist",
                border: 1,
                route: Home(),),
            ],
          ),
        ),
      ],
    ),
    );
  }
}
//0xFFfff5eb
//0xFFfdfdf2