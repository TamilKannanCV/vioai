import 'package:dartz/dartz.dart';
import 'package:vioai/data/openAI/models/message.dart';

typedef Prompt = String;

abstract interface class AppRepository {
  Future<Either<dynamic, Message>> getBotResposneForPrompt(Prompt prompt);
}
