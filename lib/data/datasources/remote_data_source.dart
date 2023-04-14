import 'package:dartz/dartz.dart';
import 'package:vioai/data/models/message.dart';
import 'package:vioai/data/repositories/repository.dart';

abstract class RemoteDataSource {
  Future<Either<Exception, Message>> getBotResponseForPrompt(Prompt prompt);
}
