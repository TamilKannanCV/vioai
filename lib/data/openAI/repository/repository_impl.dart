import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:vioai/data/openAI/models/message.dart';
import 'package:vioai/data/openAI/repository/repository.dart';
import 'package:vioai/data/openAI/service/openai_service.dart';
import 'package:vioai/logger.dart';

@Injectable(as: AppRepository)
class AppRepositoryImpl implements AppRepository {
  final OpenAIService _service;

  AppRepositoryImpl(this._service);

  @override
  Future<Either<dynamic, Message>> getBotResposneForPrompt(
      Prompt prompt) async {
    try {
      final response = await _service.getBotResponseForPrompt(prompt);
      if (response == null) {
        return Left(Exception());
      }
      return Right(response);
    } catch (e) {
      logger.e(e);
      return Left(e);
    }
  }
}
