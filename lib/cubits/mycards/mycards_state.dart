part of 'mycards_bloc.dart';

abstract class MyCardsState extends Equatable {
  const MyCardsState();

  @override
  List<Object> get props => [];
}

class MyCardsLoading extends MyCardsState {
  const MyCardsLoading();
}

class MyCardsLoaded extends MyCardsState {
  final List<Data> mycards;
  const MyCardsLoaded({this.mycards = const <Data>[]});

  @override
  List<Object> get props => [mycards];
}
