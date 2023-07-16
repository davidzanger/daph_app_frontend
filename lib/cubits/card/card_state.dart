
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:langapp/models/data.dart';

@immutable
class CardState extends Equatable {
 final Data? data;

 const CardState({
    this.data,
  });

  @override
 List<Object?> get props => [
 data];
}

@immutable
class CardDefault extends CardState {}

@immutable
class CardDataUpdated extends CardState {
 const CardDataUpdated({Data? data}) : super(data: data);
}

