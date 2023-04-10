import 'package:dio/dio.dart';
import 'package:vioai/data/datasources/remote_data_source.dart';
import 'package:vioai/data/models/message.dart';
import 'package:vioai/data/repositories/repository.dart';
import 'package:vioai/interceptors/authorization_interceptor.dart';
import 'package:vioai/interceptors/logger_interceptor.dart';

class OpenAIDataSource implements RemoteDataSource {
  final _dio = Dio(
    BaseOptions(baseUrl: "https://api.openai.com"),
  )..interceptors.addAll([
      LoggerInterceptor(),
      AuthorizationInterceptor(),
    ]);

  @override
  Future<Message> getBotResponseForMessages(Messages messages) async {
    final response = await _dio.post(
      "/v1/chat/completions",
      data: {"model": "gpt-3.5-turbo", "messages": messages},
    );
    return Message.fromMap(response.data['choices'][0]['message']);
  }
}
