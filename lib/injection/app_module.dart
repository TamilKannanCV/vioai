import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:vioai/data/openAI/client/rest_client.dart';
import 'package:vioai/router/app_router.dart';
import 'package:vioai/interceptors/authorization_interceptor.dart';
import 'package:vioai/interceptors/logger_interceptor.dart';

typedef ScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>;

@module
abstract class AppModule {
  @injectable
  Dio get dio => Dio()
    ..interceptors.addAll([
      LoggerInterceptor(),
      AuthorizationInterceptor(),
    ]);

  @injectable
  RestClient get client => RestClient(dio);

  @injectable
  AppRouter get appRouter => AppRouter();

  @injectable
  ScaffoldMessengerKey get scaffoldMessengerState => ScaffoldMessengerKey();

  @injectable
  FirebaseAuth get auth => FirebaseAuth.instance;

  @injectable
  GoogleSignIn get googleSignIn => GoogleSignIn();
}
