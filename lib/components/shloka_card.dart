import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class ShlokaCard extends StatefulWidget {
  final int selectedVerse;
  final int chapter;

  const ShlokaCard({
    super.key,
    required this.selectedVerse,
    required this.chapter,
  });

  @override
  State<ShlokaCard> createState() => _ShlokaCardState();
}

class _ShlokaCardState extends State<ShlokaCard> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  Future<void> _playAudio(String url) async {
    try {
      await _audioPlayer.play(UrlSource(url));
      setState(() => isPlaying = true);

      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() => isPlaying = false);
      });
    } catch (e) {
      debugPrint("Audio error: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = Provider.of<LanguageProvider>(context).langCode;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("verses")
          .where("chapter", isEqualTo: widget.chapter)
          .where("verse", isEqualTo: widget.selectedVerse)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            final doc = snapshot.data!.docs[0];

            final String audioUrl = doc["audio_url"] ?? "";

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.orange[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (langCode == "en")
                                    ? Text(
                                        "Verse: ${doc["id"]}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Text(
                                        "Verse: ${doc["id_hi"]}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.brown,
                                  ),
                                  tooltip: "Add to Favorites",
                                  iconSize: 30,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              doc["sanskrit"] ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),

                            Text(
                              "Meaning:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[700],
                              ),
                            ),
                            const SizedBox(height: 6),
                            (langCode=="en")?
                            Text(
                              doc["translation_en"] ?? "",
                              style: const TextStyle(fontSize: 14),
                            ):
                            Text(
                              doc["translation_hi"] ?? "",
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 20),

                            // 🎵 Audio Section
                            Row(
                              children: [
                                if (audioUrl.isNotEmpty)
                                  ElevatedButton.icon(
                                    onPressed: () => _playAudio(audioUrl),
                                    icon: Icon(
                                      isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                    ),
                                    label: Text(
                                      isPlaying
                                          ? "Playing..."
                                          : "Play Recitation",
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.brown,
                                      foregroundColor: Colors.white,
                                    ),
                                  )
                                else
                                  const Text(
                                    "No audio available",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                IconButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Add to Favorites (coming soon)",
                                        ),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.add_circle,
                                    color: Colors.brown,
                                  ),
                                  tooltip: "Add to Playlist",
                                  iconSize: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // ➕ Floating Plus Icon Button
              ],
            );
          } else {
            return const Center(child: Text("Shloka not found"));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
