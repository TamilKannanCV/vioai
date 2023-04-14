import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'interceptors/authorization_interceptor.dart';
import 'interceptors/logger_interceptor.dart';

@module
abstract class AppModule {
  @injectable
  Dio get dio => Dio()
    ..interceptors.addAll([
      LoggerInterceptor(),
      AuthorizationInterceptor(),
    ]);
}
