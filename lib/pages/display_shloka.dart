import "package:bhagavad_gita/components/appbar.dart";
import "package:bhagavad_gita/components/shloka_card.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../providers/language_provider.dart";

class DisplayShloka extends StatefulWidget {
  final String chapter;
  const DisplayShloka({super.key, required this.chapter});

  @override
  State<DisplayShloka> createState() => _DisplayShlokaState();
}

class _DisplayShlokaState extends State<DisplayShloka> {
  int selectedVerse = 1;

  @override
  Widget build(BuildContext context) {
    final langCode = Provider.of<LanguageProvider>(context).langCode;
    final int chapterNumber = int.tryParse(widget.chapter) ?? 1;
    return Bar(
      child: Column(
        children: [
          // Top Title
          Container(
            alignment: Alignment.center,
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 60,
            child: Text(
              "Chapter ${widget.chapter}",
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),

          // Shloka content display area
          Expanded(child: Container(
              child: ShlokaCard(chapter: chapterNumber,selectedVerse: selectedVerse,)
          ),

          ),

          // Bottom horizontal scroll bar for verses
          StreamBuilder(

            stream: FirebaseFirestore.instance

                .collection("verses")
                .where("chapter", isEqualTo: chapterNumber)
                .orderBy("verse")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  final docs = snapshot.data!.docs;

                  return Container(
                    height: 60,
                    color: Colors.brown[100],
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: docs.map((doc) {
                          final int verseNum = doc["verse"];
                          final String hindi_verse_num =doc["verse_hi"];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedVerse = verseNum;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedVerse == verseNum
                                    ? Colors.brown
                                    : Colors.orange,
                              ),
                              child:(langCode=="en")?
                              Text("Verse $verseNum"):Text("Verse $hindi_verse_num"),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(height: 60,
                      child: Center(child: Text("No verses found")));
                }
              } else {
                return const SizedBox(height: 60,
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ],
      ),
    );
  }
}