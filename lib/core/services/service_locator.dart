import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_cubit.dart';
import 'package:pui_bhasbi_mobile/common/bloc/nav/nav_cubit.dart';
import 'package:pui_bhasbi_mobile/core/networks/dio_client.dart';
import 'package:pui_bhasbi_mobile/core/services/location_service.dart';
import 'package:pui_bhasbi_mobile/features/auth/data/repository/auth_repository_impl.dart';
import 'package:pui_bhasbi_mobile/features/auth/data/source/auth_api_service.dart';
import 'package:pui_bhasbi_mobile/features/auth/data/source/auth_local_services.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/get_local_user_usecase.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/is_logged_in_usecase.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/login_usecase.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/logout_usecase.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/register_usecase.dart';
import 'package:pui_bhasbi_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pui_bhasbi_mobile/features/home/data/repository/fish_repository_impl.dart';
import 'package:pui_bhasbi_mobile/features/home/data/source/fish_api_service.dart';
import 'package:pui_bhasbi_mobile/features/home/domain/repository/fish_repository.dart';
import 'package:pui_bhasbi_mobile/features/home/domain/usecase/get_fish_detail_usecase.dart';
import 'package:pui_bhasbi_mobile/features/home/domain/usecase/get_fish_list_usecase.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/bloc/fish_cubit.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/bloc/fish_detail_cubit.dart';
import 'package:pui_bhasbi_mobile/features/report/presentation/bloc/approved_reports_cubit.dart'; // NEW
import 'package:pui_bhasbi_mobile/features/report/data/repository/report_repository_impl.dart';
import 'package:pui_bhasbi_mobile/features/report/data/source/report_api_service.dart';
import 'package:pui_bhasbi_mobile/features/report/domain/repository/report_repository.dart';
import 'package:pui_bhasbi_mobile/features/report/domain/usecase/get_approved_reports_usecase.dart';
import 'package:pui_bhasbi_mobile/features/report/domain/usecase/submit_report_usecase.dart';
import 'package:pui_bhasbi_mobile/features/report/presentation/bloc/report_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> setUpServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<Logger>(() => Logger());
  sl.registerLazySingleton<LocationService>(() => LocationService());

  // Data Sources
  sl.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl(sl()));
  sl.registerLazySingleton<AuthLocalService>(() => AuthLocalServiceImpl(sl()));
  sl.registerLazySingleton<FishApiService>(() => FishApiServiceImpl(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<FishRepository>(() => FishRepositoryImpl(sl()));

  // UseCases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<IsLoggedInUseCase>(() => IsLoggedInUseCase(sl()));
  sl.registerLazySingleton<GetFishListUseCase>(() => GetFishListUseCase(sl()));
  sl.registerLazySingleton<GetFishDetailUseCase>(
    () => GetFishDetailUseCase(sl()),
  );
  sl.registerLazySingleton<GetLocalUserUseCase>(
    () => GetLocalUserUseCase(sl()),
  );
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(sl()));

  // BLoCs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
  sl.registerLazySingleton<AuthStateCubit>(() => AuthStateCubit());
  sl.registerLazySingleton<NavigationCubit>(() => NavigationCubit());
  sl.registerFactory<FishCubit>(() => FishCubit(sl(), sl()));
  sl.registerFactory<FishDetailCubit>(() => FishDetailCubit(sl()));

  // Report Feature
  sl.registerLazySingleton<ReportApiService>(() => ReportApiServiceImpl(sl()));
  sl.registerLazySingleton<ReportRepository>(() => ReportRepositoryImpl(sl()));
  sl.registerLazySingleton<GetApprovedReportsUseCase>(
    () => GetApprovedReportsUseCase(sl()),
  );
  sl.registerLazySingleton<SubmitReportUseCase>(
    () => SubmitReportUseCase(sl()),
  );
  sl.registerFactory<ReportCubit>(() => ReportCubit(sl(), sl()));
  sl.registerFactory<ApprovedReportsCubit>(() => ApprovedReportsCubit(sl()));
}
