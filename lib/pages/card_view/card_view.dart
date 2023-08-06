import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langapp/models/data.dart';
import 'package:langapp/pages/repository/repository_view.dart';

class CardView extends StatelessWidget {
  final Data data;
  const CardView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card View'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WordListRow(wordList: data.words),
            Text(data.generatedText),
          ],
        ),
      ),
    );
  }
}
