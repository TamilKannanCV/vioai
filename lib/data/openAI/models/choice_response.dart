import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

part 'choice_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChoiceResponse {
  final Message? message;
  final String? finishReason;
  final int index;

  ChoiceResponse({
    this.message,
    this.finishReason,
    required this.index,
  });

  factory ChoiceResponse.fromJson(Map<String, dynamic> data) =>
      _$ChoiceResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ChoiceResponseToJson(this);
}
