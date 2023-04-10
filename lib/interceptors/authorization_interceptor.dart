import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthorizationInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final apiKey = dotenv.get("OPENAI_API_KEY");
    response.headers
      ..add("Authorization", "Bearer $apiKey")
      ..add("Content-Type", "application/json");
    super.onResponse(response, handler);
  }
}
