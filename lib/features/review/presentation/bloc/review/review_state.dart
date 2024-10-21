part of 'review_bloc.dart';

sealed class ReviewState {}

final class ReviewInitial extends ReviewState {}

final class ReviewLoading extends ReviewState {}

final class ReviewAddSuccess extends ReviewState {
  final int prudctId;
  ReviewAddSuccess({required this.prudctId});
}

final class ReviewDeleteSuccess extends ReviewState {
  final int idReview;
  ReviewDeleteSuccess({required this.idReview});
}

final class ReviewList extends ReviewState {
  final int idProduct;
  final List<Review> reviews;
  ReviewList({required this.idProduct, required this.reviews});
}

final class ReviewFailure extends ReviewState {
  final Failure failure;
  ReviewFailure({required this.failure});
}
