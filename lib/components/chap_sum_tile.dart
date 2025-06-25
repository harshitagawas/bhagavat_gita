import 'package:bhagavad_gita/pages/display_chapter_summary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class ChapSumTile extends StatefulWidget {
  const ChapSumTile({super.key});

  @override
  State<ChapSumTile> createState() => _ChapSumTileState();
}

class _ChapSumTileState extends State<ChapSumTile> {
  @override
  Widget build(BuildContext context) {
    final langCode = Provider.of<LanguageProvider>(context).langCode;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("chapters")
          .orderBy("chap_number")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final doc = docs[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SummaryPage(
                          chapNum: (langCode=="en")?doc["chap_number"].toString():doc["chap_number_hi"],
                          chapName: (langCode=="en")? doc["name_en"]:doc["name_hi"],
                          summary: (langCode =="en")? doc["summary_en"]:doc["summary_hi"],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color(0xFF903e1d),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (langCode=="en")?
                            Text(
                              "${doc["chap_number"]}",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFF8F0),
                              ),
                            ):
                                Text("${doc["chap_number_hi"]}",
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFF8F0),
                                  ),),
                            (langCode =="en")?
                            Text(
                              "${doc["name_en"]}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFFFFF8F0),
                              ),
                            ):
                            Text(
                              "${doc["name_hi"]}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFFFFF8F0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return const Center(child: Text("No data found"));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
