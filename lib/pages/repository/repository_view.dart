import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langapp/cubits/mycards/mycards_bloc.dart';
import 'package:langapp/models/data.dart';
import 'package:langapp/pages/card_view/card_view.dart';

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
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CardView(data: dataList[index])));
            },
            child: VocabularyCard(data: dataList[index], index: index));
      },
    );
  }
}

class VocabularyCard extends StatelessWidget {
  const VocabularyCard({
    super.key,
    required this.data,
    required this.index,
  });

  final Data data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: WordListRow(wordList: data.words),
        subtitle: Text(
            "${data.textLength.toString()} words, ${data.difficulty.name}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<MyCardsBloc>(context)
                      .add(DeleteCard(card: data));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Card deleted from repository'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          BlocProvider.of<MyCardsBloc>(context)
                              .add(InsertCard(card: data, index: index));
                        },
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: Icon(Icons.delete)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
      ),
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
