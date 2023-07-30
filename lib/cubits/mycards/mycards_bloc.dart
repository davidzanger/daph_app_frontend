import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/data.dart';

part 'mycards_event.dart';
part 'mycards_state.dart';

class MyCardsBloc extends Bloc<MyCardsEvent, MyCardsState> {
  MyCardsBloc() : super(const MyCardsLoading()) {
    on<LoadMyCards>(_onLoadMyCards);
    on<AddCard>(_onAddCard);
    on<DeleteCard>(_onDeleteCard);
    on<InsertCard>(_onInsertCard);
  }
  void _onLoadMyCards(
    LoadMyCards event,
    Emitter<MyCardsState> emit,
  ) {
    emit(MyCardsLoaded(mycards: event.mycards));
  }

  void _onAddCard(
    AddCard event,
    Emitter<MyCardsState> emit,
  ) {
    final state = this.state;
    if (state is MyCardsLoaded) {
      final List<Data> mycards = List<Data>.from(state.mycards);
      mycards.add(event.card);
      emit(MyCardsLoaded(mycards: mycards));
    }
  }

  void _onDeleteCard(
    DeleteCard event,
    Emitter<MyCardsState> emit,
  ) {
    final state = this.state;
    if (state is MyCardsLoaded) {
      final List<Data> mycards = List<Data>.from(state.mycards);
      mycards.remove(event.card);
      emit(MyCardsLoaded(mycards: mycards));
    }
  }
  void _onInsertCard(
    InsertCard event,
    Emitter<MyCardsState> emit,
  ) {
    final state = this.state;
    if (state is MyCardsLoaded) {
      final List<Data> mycards = List<Data>.from(state.mycards);
      mycards.insert(event.index, event.card);
      emit(MyCardsLoaded(mycards: mycards));
    }
  }
}
