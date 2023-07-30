part of 'mycards_bloc.dart';

abstract class MyCardsEvent extends Equatable {
  const MyCardsEvent();

  @override
  List<Object> get props => [];
}

class LoadMyCards extends MyCardsEvent {
  final List<Data> mycards;
  const LoadMyCards({this.mycards = const <Data>[]});

  @override
  List<Object> get props => [mycards];
}

class AddCard extends MyCardsEvent {
  final Data card;
  const AddCard({required this.card});

  @override
  List<Object> get props => [card];
}

class DeleteCard extends MyCardsEvent {
  final Data card;
  const DeleteCard({required this.card});

  @override
  List<Object> get props => [card];
}
