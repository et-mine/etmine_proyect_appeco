import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:etmine_proyect_appeco/core/error/failures.dart';
import 'package:etmine_proyect_appeco/core/utils/utils.dart';
import 'package:etmine_proyect_appeco/features/review/data/datasources/reviews_local_data_resources.dart';
import 'package:etmine_proyect_appeco/features/review/data/datasources/reviews_remote_data_sources.dart';
import 'package:etmine_proyect_appeco/features/review/domain/entities/review.dart';
import 'package:etmine_proyect_appeco/features/review/domain/repositories/reviews_repository.dart';
import 'package:random_date/random_date.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsLocalDataResources reviewsLocalDataResources;
  final ReviewsRemoteDataSources reviewsRemoteDataSources;

  ReviewsRepositoryImpl(
      {required this.reviewsLocalDataResources,
      required this.reviewsRemoteDataSources});

  @override
  Future<Either<Failure, int>> addReview(Review review) async {
    try {
      final int resp = await reviewsLocalDataResources.addReview(review);
      return Right(resp);
    } on LocalFailure {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteReview(int idReview) async {
    try {
      final bool resp = await reviewsLocalDataResources.deleteReview(idReview);
      return Right(resp);
    } on LocalFailure {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getAllReviews(int id) async {
    try {
      List<Review> res = [];
      final List<Review> respLocal =
          await reviewsLocalDataResources.getReviewsList(id);
      if (respLocal.isEmpty) {
        final List<Review> respRemote =
            await reviewsRemoteDataSources.getReviewsList(id);
        int contId = 1;
        for (var rev in respRemote) {
          DateTime randomDate = RandomDate.withStartYear(2023).random();
          DateTime currentDate = DateTime.now();
          if (randomDate.isAfter(currentDate)) {
            randomDate = currentDate;
          }
          rev.id = contId;
          rev.idProduct = id;
          rev.cantStars = randomStar;
          rev.userImgUrl = 'https://picsum.photos/$randomImage';
          rev.userName = rev.userName.split('@')[0].trim();
          rev.timeReview = randomDate.toString();
          contId++;
          await reviewsLocalDataResources.addReview(rev);
        }
        List<Review> respRemoteUpd = convertTimeAgoReviewList(respRemote);
        res = respRemoteUpd;
      } else {
        List<Review> respLocalUpd = convertTimeAgoReviewList(respLocal);
        res = respLocalUpd;
      }

      return Right(res);
    } on DioException {
      return Left(ServerFailure());
    }
  }
}
