import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langapp/cubits/mycards/mycards_bloc.dart';
import 'package:langapp/models/data.dart';

class RepositoryView extends StatelessWidget {
  const RepositoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCardsBloc, MyCardsState>(
      builder: (context, state) {
        if (state is MyCardsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MyCardsLoaded) {
          final List<Data> dataList = state.mycards;
          return MyCardsListView(dataList: dataList);
        } else {
          return const Center(child: Text("Something went wrong!"));
        }
      },
    );
  }
}

class MyCardsListView extends StatelessWidget {
  const MyCardsListView({
    super.key,
    required this.dataList,
  });

  final List<Data> dataList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: WordListRow(wordList: dataList[index].words),
            subtitle: Text(
                "${dataList[index].textLength.toString()} words, ${dataList[index].difficulty.name}"),
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
