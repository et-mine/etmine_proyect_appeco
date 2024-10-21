import 'package:dartz/dartz.dart';
import 'package:etmine_proyect_appeco/core/error/failures.dart';
import 'package:etmine_proyect_appeco/features/review/domain/entities/review.dart';
import 'package:etmine_proyect_appeco/features/review/domain/repositories/reviews_repository.dart';

class AddReviewsUseCase {
  final ReviewsRepository reviewsRepository;
  AddReviewsUseCase({required this.reviewsRepository});

  Future<Either<Failure, int>> call(Review review) {
    return reviewsRepository.addReview(review);
  }
}
