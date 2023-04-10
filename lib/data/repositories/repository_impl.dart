import 'package:vioai/data/datasources/remote_data_source.dart';
import 'package:vioai/data/models/message.dart';
import 'package:vioai/data/repositories/repository.dart';
import 'package:vioai/logger.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._remoteDataSource);

  @override
  Future<Message> getBotResposneForMessages(Messages messages) async {
    try {
      final response = await _remoteDataSource.getBotResponseForMessages(messages);
      return response;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
