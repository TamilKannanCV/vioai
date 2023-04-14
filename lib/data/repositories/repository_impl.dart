import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:vioai/data/datasources/remote_data_source.dart';
import 'package:vioai/data/models/message.dart';
import 'package:vioai/data/repositories/repository.dart';

@Injectable(as: AppRepository)
class AppRepositoryImpl implements AppRepository {
  final RemoteDataSource _remoteDataSource;

  AppRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Exception, Message>> getBotResposneForPrompt(
      Prompt prompt) async {
    final response = await _remoteDataSource.getBotResponseForPrompt(prompt);
    return response.fold((e) {
      return Left(e);
    }, (r) {
      return Right(r);
    });
  }
}
