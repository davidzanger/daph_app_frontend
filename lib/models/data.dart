import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'data.g.dart';
part 'data.freezed.dart';

enum Difficulty { easy, medium, hard }

@freezed
class Data with _$Data {
  const factory Data({
    @Default([]) List<String> words,
    @Default(500) int textLength,
    @Default(Difficulty.medium) Difficulty difficulty,
    @Default("") String generatedText,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
