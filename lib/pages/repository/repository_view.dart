import 'package:flutter/material.dart';
import 'package:langapp/models/data.dart';

class RepositoryView extends StatelessWidget {
  const RepositoryView({super.key});
  final _dataList = const <Data>[
    Data(
      textLength: 10,
      difficulty: Difficulty.easy,
      words: <String>["Philipp", "is", "gay"],
    ),
    Data(
      textLength: 20,
      difficulty: Difficulty.medium,
      words: <String>[
        "hello",
        "worldasdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
        "asddddddddddddddddddddddddddddddddddddddddddddddddddddddd"
      ],
    ),
    Data(
      textLength: 30,
      difficulty: Difficulty.hard,
      words: <String>["hello", "world"],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _dataList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: WordListRow(wordList: _dataList[index].words),
            subtitle: Text(
                "${_dataList[index].textLength.toString()} words, ${_dataList[index].difficulty.name}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class WordListRow extends StatelessWidget {
  final List<String> wordList;
  const WordListRow({super.key, required this.wordList});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 4,
      children: [
        for (var word in wordList)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: SelectableText(
                word,
              ),
            ),
          ),
      ],
    );
  }
}
