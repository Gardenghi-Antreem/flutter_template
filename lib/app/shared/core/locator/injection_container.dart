import 'package:flutter_template/app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_template/app/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:flutter_template/app/shared/core/api/api_manager.dart';
import 'package:flutter_template/app/shared/core/config/config.dart';
import 'package:flutter_template/app/shared/data/data_sources/authentication_data_source.dart';
import 'package:flutter_template/app/shared/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_template/app/shared/data/repositories/settings_repository_impl.dart';
import 'package:flutter_template/app/shared/domain/repositories/authentication_repository.dart';
import 'package:flutter_template/app/shared/domain/repositories/settings_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl

    // SHARED
    ..registerLazySingleton<Config>(
      Config.new,
    )
    ..registerLazySingleton<SettingsRepository>(
      SettingsRepositoryImplementation.new,
    )
    ..registerLazySingleton<ApiManager>(() => ApiManager(config: sl()))

    // AUTH
    ..registerLazySingleton<AuthenticationDataSource>(
      () => AuthenticationDataSource(apiManager: sl()),
    )
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(dataSource: sl()),
    )
    ..registerFactory<LoginBloc>(() => LoginBloc(loginRepository: sl()))

    // SPLASH
    ..registerFactory<SplashCubit>(
      () => SplashCubit(settingsRepository: sl()),
    );

  // Bloc with params exemple
  // ..registerFactoryParam<ExempleBloc, BuildContext, ExempleBlocParams>(
  //   (BuildContext _, ExempleBlocParams params) => ExempleBloc(
  //     params: params,
  //   ),
  // )
}
