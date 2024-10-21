import 'package:dartz/dartz.dart';
import 'package:etmine_proyect_appeco/core/error/failures.dart';
import 'package:etmine_proyect_appeco/features/review/domain/entities/review.dart';

abstract class ReviewsRepository {
  Future<Either<Failure, int>> addReview(Review review);
  Future<Either<Failure, bool>> deleteReview(int idReview);
  Future<Either<Failure, List<Review>>> getAllReviews(int prodId);
}
