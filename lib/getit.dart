import 'package:etmine_proyect_appeco/features/review/data/datasources/reviews_local_data_resources.dart';
import 'package:etmine_proyect_appeco/features/review/data/datasources/reviews_remote_data_sources.dart';
import 'package:etmine_proyect_appeco/features/review/data/repositories/reviews_repository_impl.dart';
import 'package:etmine_proyect_appeco/features/review/domain/repositories/reviews_repository.dart';
import 'package:etmine_proyect_appeco/features/review/domain/use_cases/add_review_use_case.dart';
import 'package:etmine_proyect_appeco/features/review/domain/use_cases/delete_review_use_case.dart';
import 'package:etmine_proyect_appeco/features/review/domain/use_cases/get_all_reviews_use_case.dart';
import 'package:etmine_proyect_appeco/features/review/presentation/bloc/review/review_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //Bloc
  getIt.registerFactory(() => ReviewBloc(getIt(), getIt(), getIt()));

  //Use Cases
  getIt.registerLazySingleton(
      () => AddReviewsUseCase(reviewsRepository: getIt()));
  getIt.registerLazySingleton(
      () => DeleteReviewsUseCase(reviewsRepository: getIt()));
  getIt.registerLazySingleton(
      () => GetAllReviewsUseCase(reviewsRepository: getIt()));

  //Repositories
  getIt.registerLazySingleton<ReviewsRepository>(() => ReviewsRepositoryImpl(
      reviewsLocalDataResources: getIt(), reviewsRemoteDataSources: getIt()));

  //DataSources
  await Hive.initFlutter();
  getIt.registerLazySingleton<ReviewsLocalDataResources>(
      () => HiveReviewsLocalDataResourcesImpl());
  getIt.registerLazySingleton<ReviewsRemoteDataSources>(
      () => ReviewsRemoteDataSourcesImpl());
}
