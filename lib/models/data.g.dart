// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Data _$$_DataFromJson(Map<String, dynamic> json) => _$_Data(
      words:
          (json['words'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      textLength: json['textLength'] as int? ?? 500,
      difficulty:
          $enumDecodeNullable(_$DifficultyEnumMap, json['difficulty']) ??
              Difficulty.medium,
      generatedText: json['generatedText'] as String? ?? "",
    );

Map<String, dynamic> _$$_DataToJson(_$_Data instance) => <String, dynamic>{
      'words': instance.words,
      'textLength': instance.textLength,
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
      'generatedText': instance.generatedText,
    };

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
};
