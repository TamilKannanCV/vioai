import 'package:injectable/injectable.dart';
import 'package:vioai/data/openAI/client/rest_client.dart';
import 'package:vioai/data/openAI/models/completion_request.dart';
import 'package:vioai/data/openAI/models/enums/role.dart';
import 'package:vioai/data/openAI/models/message.dart';
import 'package:vioai/data/openAI/repository/repository.dart';

@injectable
class OpenAIService {
  final RestClient _restClient;

  OpenAIService(this._restClient);

  Future<Message?> getBotResponseForPrompt(Prompt prompt) async {
    final request = CompletionRequest(
      messages: [Message(role: Role.user.name, content: prompt)],
      maxTokens: 256,
    );
    final completionResponse = await _restClient.getCompletionReponse(request);
    final message = completionResponse.choices?.first.message;
    return message;
  }
}

class EmptyMessageException implements Exception {}
