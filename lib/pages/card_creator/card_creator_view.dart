import 'package:flutter/material.dart';
import 'package:langapp/cubits/data/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langapp/cubits/mycards/mycards_bloc.dart';
import 'package:langapp/models/data.dart';

class CardCreatorView extends StatefulWidget {
  const CardCreatorView({super.key});

  @override
  State<CardCreatorView> createState() => _CardCreatorViewState();
}

class _CardCreatorViewState extends State<CardCreatorView> {
  Data _data = Data();

  void updateTextLength(double textLength) {
    setState(() {
      _data = _data.copyWith(textLength: textLength.round());
    });
  }

  void updateDifficulty(Difficulty? difficulty) {
    setState(() {
      _data = _data.copyWith(difficulty: difficulty!);
    });
  }

  void updateWords(String words) {
    setState(() {
      _data = _data.copyWith(words: words.split(","));
    });
  }

  @override
  void initState() {
    super.initState();
    DataCubit.cubit(context).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            onChanged: updateWords,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  'List the words you want to learn separated by a comma.',
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          child: TextLengthSlider(
            currentSliderValue: _data.textLength.toDouble(),
            onChange: updateTextLength,
          ),
        ),
        Container(
          child: DifficultyRadio(
            character: _data.difficulty,
            onChange: updateDifficulty,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => {DataCubit.cubit(context).generateText(_data)},
              child: const Text('Generate Text'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        GeneratedText(card: _data),
      ],
    );
  }
}

class GeneratedText extends StatelessWidget {
  const GeneratedText({
    super.key,
    required Data card,
  }) : _card = card;

  final Data _card;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      builder: (context, state) {
        // loading
        if (state is DataFetchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // success
        else if (state is DataFetchSuccess) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.data!.generatedText),
                const SizedBox(height: 20),
                BlocListener<MyCardsBloc, MyCardsState>(
                  listener: (context, myBlocState) {},
                  child: ElevatedButton(
                    onPressed: () => {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Card added to repository'),
                          duration: Duration(seconds: 1),
                        ),
                      ),
                      context.read<MyCardsBloc>().add(AddCard(
                          card: _card.copyWith(
                              generatedText: state.data!.generatedText))),
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ]);
        }

        // failure
        else if (state is DataFetchFailed) {
          return Center(
            child: Text(_card.toString()),
          );
        }

        // something unexpected
        return const Center(
          child: Text('Something went wrong'),
        );
      },
    );
  }
}

class TextLengthSlider extends StatelessWidget {
  final double currentSliderValue;
  final ValueChanged<double> onChange;
  const TextLengthSlider(
      {super.key, this.currentSliderValue = 200, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${currentSliderValue.truncate()}'),
        Expanded(
          child: Slider(
              value: currentSliderValue,
              divisions: 2000 ~/ 50,
              max: 2000,
              label: currentSliderValue.round().toString(),
              onChanged: onChange),
        ),
      ],
    );
  }
}

class DifficultyRadio extends StatelessWidget {
  final Difficulty character;
  final ValueChanged<Difficulty?> onChange;
  const DifficultyRadio(
      {super.key, required this.character, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 200,
          child: ListTile(
            title: const Text('Easy'),
            leading: Radio<Difficulty>(
              value: Difficulty.easy,
              groupValue: character,
              onChanged: onChange,
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: ListTile(
            title: const Text('Medium'),
            leading: Radio<Difficulty>(
                value: Difficulty.medium,
                groupValue: character,
                onChanged: onChange),
          ),
        ),
        SizedBox(
          width: 200,
          child: ListTile(
            title: const Text('Hard'),
            leading: Radio<Difficulty>(
                value: Difficulty.hard,
                groupValue: character,
                onChanged: onChange),
          ),
        ),
      ],
    );
  }
}
