import 'package:dartz/dartz.dart';
import 'package:etmine_proyect_appeco/core/error/failures.dart';
import 'package:etmine_proyect_appeco/features/review/domain/repositories/reviews_repository.dart';

class DeleteReviewsUseCase {
  final ReviewsRepository reviewsRepository;
  DeleteReviewsUseCase({required this.reviewsRepository});

  Future<Either<Failure, bool>> call(int idReview) {
    return reviewsRepository.deleteReview(idReview);
  }
}
