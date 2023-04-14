import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:vioai/data/datasources/remote_data_source.dart';
import 'package:vioai/data/models/completion_request.dart';
import 'package:vioai/data/models/completion_response.dart';
import 'package:vioai/data/models/enums/role.dart';
import 'package:vioai/data/models/message.dart';
import 'package:vioai/data/repositories/repository.dart';
import 'package:vioai/logger.dart';

@Injectable(as: RemoteDataSource)
class OpenAIDataSource implements RemoteDataSource {
  final Dio dio;

  OpenAIDataSource(this.dio);

  Dio get _dio =>
      dio..options = BaseOptions(baseUrl: 'https://api.openai.com/v1');

  @override
  Future<Either<Exception, Message>> getBotResponseForPrompt(
      Prompt prompt) async {
    final request = CompletionRequest(
      messages: [Message(role: Role.user.name, content: prompt)],
      maxTokens: 256,
    );    
    try {
      final response = await _dio.post(
        '/chat/completions',
        data: json.encode(request.toJson()),
      );

      final completionResponse = CompletionResponse.fromJson(response.data);
      final message = completionResponse.choices?.first.message;
      if (message == null) {
        return Left(EmptyMessageException());
      }
      return Right(message);
    } catch (e) {
      logger.e(e);
      return Left(Exception(e));
    }
  }
}

class EmptyMessageException implements Exception {}
