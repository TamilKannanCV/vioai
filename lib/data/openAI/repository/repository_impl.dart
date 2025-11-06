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
  Future<Either<String, Message>> getBotResposneForPrompt(Prompt prompt) async {
    try {
      final response = await _service.getBotResponseForPrompt(prompt);
      if (response == null) {
        return const Left('No response received from AI');
      }
      return Right(response);
    } on RateLimitException catch (e) {
      logger.e('Rate limit error: $e');
      return const Left(
          'Rate limit exceeded. Please wait a moment and try again.\n\n💡 Tip: You may have exceeded your OpenAI API quota or request limit.');
    } on AuthenticationException catch (e) {
      logger.e('Authentication error: $e');
      return const Left('Authentication failed. Please check your API key configuration.');
    } on BadRequestException catch (e) {
      logger.e('Bad request: $e');
      return Left('Invalid request: ${e.message}');
    } on ServerException catch (e) {
      logger.e('Server error: $e');
      return const Left('OpenAI service is temporarily unavailable. Please try again later.');
    } catch (e) {
      logger.e('Unexpected error: $e');
      return Left('An unexpected error occurred: ${e.toString()}');
    }
  }
}
