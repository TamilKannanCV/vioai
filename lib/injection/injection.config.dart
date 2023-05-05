// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:vioai/data/authentication/repository/authentication_repo.dart'
    as _i13;
import 'package:vioai/data/authentication/repository/authentication_repo_impl.dart'
    as _i14;
import 'package:vioai/data/authentication/service/authentication_service.dart'
    as _i9;
import 'package:vioai/data/openAI/client/rest_client.dart' as _i8;
import 'package:vioai/data/openAI/repository/repository.dart' as _i11;
import 'package:vioai/data/openAI/repository/repository_impl.dart' as _i12;
import 'package:vioai/data/openAI/service/openai_service.dart' as _i10;
import 'package:vioai/injection/app_module.dart' as _i17;
import 'package:vioai/router/app_router.dart' as _i3;
import 'package:vioai/views/home/home_screen_viewmodel.dart' as _i16;
import 'package:vioai/views/home/widgets/chat_message_vm.dart' as _i15;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i3.AppRouter>(() => appModule.appRouter);
    gh.factory<_i4.Dio>(() => appModule.dio);
    gh.factory<_i5.FirebaseAuth>(() => appModule.auth);
    gh.factory<_i6.GlobalKey<_i6.ScaffoldMessengerState>>(
        () => appModule.scaffoldMessengerState);
    gh.factory<_i7.GoogleSignIn>(() => appModule.googleSignIn);
    gh.factory<_i8.RestClient>(() => appModule.client);
    gh.factory<_i9.AuthenticationService>(() => _i9.AuthenticationService(
          gh<_i5.FirebaseAuth>(),
          gh<_i7.GoogleSignIn>(),
        ));
    gh.factory<_i10.OpenAIService>(
        () => _i10.OpenAIService(gh<_i8.RestClient>()));
    gh.factory<_i11.AppRepository>(
        () => _i12.AppRepositoryImpl(gh<_i10.OpenAIService>()));
    gh.factory<_i13.AuthenticationRepo>(
        () => _i14.AuthenticationRepoImpl(gh<_i9.AuthenticationService>()));
    gh.factory<_i15.ChatMessageVm>(() => _i15.ChatMessageVm(
          gh<_i11.AppRepository>(),
          gh<_i6.GlobalKey<_i6.ScaffoldMessengerState>>(),
        ));
    gh.factory<_i16.HomeScreenViewModel>(() => _i16.HomeScreenViewModel(
          gh<_i11.AppRepository>(),
          gh<_i13.AuthenticationRepo>(),
          gh<_i6.GlobalKey<_i6.ScaffoldMessengerState>>(),
        ));
    return this;
  }
}

class _$AppModule extends _i17.AppModule {}
