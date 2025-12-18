import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_cubit.dart';
import 'package:pui_bhasbi_mobile/core/networks/dio_client.dart';
import 'package:pui_bhasbi_mobile/features/auth/data/repository/auth_repository_impl.dart';
import 'package:pui_bhasbi_mobile/features/auth/data/source/auth_api_service.dart';
import 'package:pui_bhasbi_mobile/features/auth/data/source/auth_local_services.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/is_logged_in_usecase.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/login_usecase.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/register_usecase.dart';
import 'package:pui_bhasbi_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> setUpServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<Logger>(() => Logger());

  // Data Sources
  sl.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl(sl()));
  sl.registerLazySingleton<AuthLocalService>(() => AuthLocalServiceImpl(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  // UseCases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<IsLoggedInUseCase>(() => IsLoggedInUseCase(sl()));

  // BLoCs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
  sl.registerLazySingleton<AuthStateCubit>(() => AuthStateCubit());
}
