import 'package:dartz/dartz.dart';
import 'package:etmine_proyect_appeco/core/error/failures.dart';
import 'package:etmine_proyect_appeco/features/review/domain/entities/review.dart';
import 'package:etmine_proyect_appeco/features/review/domain/repositories/reviews_repository.dart';

class GetAllReviewsUseCase {
  final ReviewsRepository reviewsRepository;
  GetAllReviewsUseCase({required this.reviewsRepository});

  Future<Either<Failure, List<Review>>> call(int id) {
    return reviewsRepository.getAllReviews(id);
  }
}
