// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChoiceResponse _$ChoiceResponseFromJson(Map<String, dynamic> json) =>
    ChoiceResponse(
      message: json['message'] == null
          ? null
          : Message.fromJson(json['message'] as Map<String, dynamic>),
      finishReason: json['finish_reason'] as String?,
      index: json['index'] as int,
    );

Map<String, dynamic> _$ChoiceResponseToJson(ChoiceResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'finish_reason': instance.finishReason,
      'index': instance.index,
    };
