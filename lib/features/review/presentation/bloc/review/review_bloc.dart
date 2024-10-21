import 'package:etmine_proyect_appeco/core/error/failures.dart';
import 'package:etmine_proyect_appeco/features/review/domain/entities/review.dart';
import 'package:etmine_proyect_appeco/features/review/domain/use_cases/add_review_use_case.dart';
import 'package:etmine_proyect_appeco/features/review/domain/use_cases/delete_review_use_case.dart';
import 'package:etmine_proyect_appeco/features/review/domain/use_cases/get_all_reviews_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final AddReviewsUseCase addReviewsUseCase;
  final DeleteReviewsUseCase deleteReviewsUseCase;
  final GetAllReviewsUseCase getAllReviewsUseCase;

  ReviewBloc(this.addReviewsUseCase, this.deleteReviewsUseCase,
      this.getAllReviewsUseCase)
      : super(ReviewInitial()) {
    on<OnAddReview>((event, emit) async {
      emit(ReviewLoading());
      final resp = await addReviewsUseCase(event.review);
      final respList = await getAllReviewsUseCase(event.review.idProduct);

      resp.fold((f) => emit(ReviewFailure(failure: f)), (p) {
        respList.fold((f) => emit(ReviewFailure(failure: f)), (rs) {
          emit(ReviewList(idProduct: p, reviews: rs));
        });
      });
    });

    on<OnDeleteReview>((event, emit) async {
      emit(ReviewLoading());
      final resp = await deleteReviewsUseCase(event.idReview);
      final respList = await getAllReviewsUseCase(event.idProduct);

      resp.fold((f) => emit(ReviewFailure(failure: f)), (p) {
        respList.fold((f) => emit(ReviewFailure(failure: f)), (rs) {
          emit(ReviewList(idProduct: event.idProduct, reviews: rs));
        });
      });
    });

    on<OnGetListReviews>(
      (event, emit) async {
        emit(ReviewLoading());
        final resp = await getAllReviewsUseCase(event.prodId);

        resp.fold((f) => emit(ReviewFailure(failure: f)),
            (rs) => emit(ReviewList(idProduct: event.prodId, reviews: rs)));
      },
    );
  }
}
