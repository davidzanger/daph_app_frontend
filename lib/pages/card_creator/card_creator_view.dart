import 'package:flutter/material.dart';
import 'package:langapp/cubits/data/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langapp/models/data.dart';

class CardCreatorView extends StatefulWidget {
  const CardCreatorView({super.key});

  @override
  State<CardCreatorView> createState() => _CardCreatorViewState();
}

class _CardCreatorViewState extends State<CardCreatorView> {
  final Map<String, dynamic> _data = <String, dynamic>{
    "words": [""],
    "textLength": 0,
    "difficulty": Difficulty.medium,
    "generatedText": "",
  };

  void updateTextLength(double textLength) {
    setState(() {
      _data["textLength"] = textLength.round();
    });
  }

  void updateDifficulty(Difficulty? difficulty) {
    setState(() {
      _data["difficulty"] = difficulty;
    });
  }

  void updateWords(String words) {
    setState(() {
      _data["words"] = words.split(",");
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
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
            currentSliderValue: _data["textLength"].toDouble(),
            onChange: updateTextLength,
          ),
        ),
        Container(
          child: DifficultyRadio(
            character: _data["difficulty"],
            onChange: updateDifficulty,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  {DataCubit.cubit(context).generateText(Data.fromJson(_data))},
              child: const Text('Generate Text'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        GeneratedText(data: _data),
      ],
    );
  }
}

class GeneratedText extends StatelessWidget {
  const GeneratedText({
    super.key,
    required Map<String, dynamic> data,
  }) : _data = data;

  final Map<String, dynamic> _data;

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
          return Center(
            child: Text(state.data!.generatedText
                    ),
            );
        }

        // failure
        else if (state is DataFetchFailed) {
          return Center(
            child: Text(
                'Current data is ${_data["textLength"]}, ${_data["difficulty"]}, ${_data["words"]} '),
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
