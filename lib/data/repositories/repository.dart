import 'package:dartz/dartz.dart';
import 'package:vioai/data/models/message.dart';

typedef Prompt = String;

abstract class AppRepository {
  Future<Either<Exception, Message>> getBotResposneForPrompt(Prompt prompt);
}
