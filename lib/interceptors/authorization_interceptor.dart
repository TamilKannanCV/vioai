import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final apiKey = dotenv.get("OPENAI_API_KEY");
    final token = 'Bearer $apiKey';

    options.headers.addEntries(
      [
        MapEntry<String, String>('Authorization', token),
        const MapEntry<String, String>('Content-Type', 'application/json'),
      ],
    );
    super.onRequest(options, handler);
  }
}
