// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:vioai/app_module.dart' as _i10;
import 'package:vioai/data/datasources/openai_data_source.dart' as _i5;
import 'package:vioai/data/datasources/remote_data_source.dart' as _i4;
import 'package:vioai/data/repositories/repository.dart' as _i6;
import 'package:vioai/data/repositories/repository_impl.dart' as _i7;
import 'package:vioai/views/screens/home/home_screen_viewmodel.dart' as _i9;
import 'package:vioai/views/widgets/chat_message_vm.dart' as _i8;

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
    gh.factory<_i3.Dio>(() => appModule.dio);
    gh.factory<_i4.RemoteDataSource>(() => _i5.OpenAIDataSource(gh<_i3.Dio>()));
    gh.factory<_i6.AppRepository>(
        () => _i7.AppRepositoryImpl(gh<_i4.RemoteDataSource>()));
    gh.factory<_i8.ChatMessageVm>(
        () => _i8.ChatMessageVm(gh<_i6.AppRepository>()));
    gh.factory<_i9.HomeScreenViewModel>(
        () => _i9.HomeScreenViewModel(gh<_i6.AppRepository>()));
    return this;
  }
}

class _$AppModule extends _i10.AppModule {}
