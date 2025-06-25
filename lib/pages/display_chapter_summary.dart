import 'package:bhagavad_gita/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class SummaryPage extends StatefulWidget {
  final String chapNum;
  final String chapName;
  final String summary;
  // final String summary_hi;
  const SummaryPage({super.key,
  required this.chapNum,
    required this.chapName,
    required this.summary,
    // required this.summary_hi,
  });

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    // final langCode = Provider.of<LanguageProvider>(context).langCode;
    return Bar(child:
    Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(

        children: [
          Text("CHAPTER ${widget.chapNum}",style: TextStyle(fontSize: 28),),
          const SizedBox(height: 10,),
          Text(widget.chapName,style: TextStyle(fontSize: 20),),
          const SizedBox(height: 10,),
          // (langCode == "en")? Text("Summary ${widget.summary_en}",style: TextStyle(fontSize: 16),): Text(widget.summary_hi,style: TextStyle(fontSize: 16),)
        Text("Summary: ${widget.summary}",style: TextStyle(fontSize: 16),)
        
        ],
        ),
      ),
    )
    );
  }
}
