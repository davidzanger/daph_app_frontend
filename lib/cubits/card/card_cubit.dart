import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langapp/cubits/card/card_state.dart';
import 'package:langapp/models/data.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardDefault());

  void updateData(Data data){
    emit(CardDataUpdated(data: data));
  }
}