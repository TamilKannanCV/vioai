import 'package:json_annotation/json_annotation.dart';
import 'package:vioai/data/openAI/models/usage_response.dart';

import 'choice_response.dart';

part 'completion_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompletionResponse {
  final String? id;
  final String? object;
  final int? created;
  final String? model;
  final UsageResponse? usage;
  final List<ChoiceResponse>? choices;

  CompletionResponse({
    this.id,
    this.object,
    this.created,
    this.model,
    this.usage,
    this.choices,
  });

  factory CompletionResponse.fromJson(Map<String, dynamic> data) =>
      _$CompletionResponseFromJson(data);

  Map<String, dynamic> toJson() => _$CompletionResponseToJson(this);
}
