import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:vioai/data/openAI/client/rest_client.dart';
import 'package:vioai/data/openAI/models/completion_request.dart';
import 'package:vioai/data/openAI/models/enums/role.dart';
import 'package:vioai/data/openAI/models/message.dart';
import 'package:vioai/data/openAI/repository/repository.dart';
import 'package:vioai/logger.dart';

@injectable
class OpenAIService {
  final RestClient _restClient;

  OpenAIService(this._restClient);

  Future<Message?> getBotResponseForPrompt(
    Prompt prompt, {
    int maxRetries = 3,
  }) async {
    int retryCount = 0;
    Duration retryDelay = const Duration(seconds: 1);

    while (retryCount < maxRetries) {
      try {
        final request = CompletionRequest(
          messages: [Message(role: Role.user.name, content: prompt)],
          maxTokens: 256,
        );
        final completionResponse = await _restClient.getCompletionReponse(request);
        final message = completionResponse.choices?.first.message;
        return message;
      } on DioError catch (e) {
        if (e.response?.statusCode == 429) {
          // Rate limit error
          retryCount++;
          if (retryCount >= maxRetries) {
            logger.e('Max retries reached for rate limit error');
            throw RateLimitException(
              'Rate limit exceeded. Please try again later.',
              retryAfter: _getRetryAfterSeconds(e.response),
            );
          }

          // Exponential backoff: wait longer with each retry
          final waitTime = retryDelay * (retryCount * 2);
          logger.w('Rate limit hit. Retrying after ${waitTime.inSeconds} seconds... (Attempt $retryCount/$maxRetries)');
          await Future.delayed(waitTime);
        } else if (e.response?.statusCode == 401) {
          // Authentication error
          throw AuthenticationException('Invalid API key or unauthorized access');
        } else if (e.response?.statusCode == 400) {
          // Bad request
          throw BadRequestException('Invalid request: ${e.response?.data}');
        } else if (e.response?.statusCode != null && e.response!.statusCode! >= 500) {
          // Server error
          throw ServerException('OpenAI server error. Please try again later.');
        } else {
          // Other errors
          rethrow;
        }
      }
    }

    throw Exception('Failed to get response after $maxRetries retries');
  }

  int? _getRetryAfterSeconds(Response? response) {
    if (response?.headers.value('retry-after') != null) {
      return int.tryParse(response!.headers.value('retry-after')!);
    }
    return null;
  }
}

class EmptyMessageException implements Exception {}

class RateLimitException implements Exception {
  final String message;
  final int? retryAfter;

  RateLimitException(this.message, {this.retryAfter});

  @override
  String toString() {
    if (retryAfter != null) {
      return 'RateLimitException: $message (Retry after $retryAfter seconds)';
    }
    return 'RateLimitException: $message';
  }
}

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);

  @override
  String toString() => 'BadRequestException: $message';
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}
