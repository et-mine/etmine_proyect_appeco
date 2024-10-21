part of 'review_bloc.dart';

sealed class ReviewEvent {}

class OnAddReview extends ReviewEvent {
  final Review review;
  OnAddReview({required this.review});
}

class OnDeleteReview extends ReviewEvent {
  final int idReview;
  final int idProduct;
  OnDeleteReview({required this.idReview, required this.idProduct});
}

class OnGetListReviews extends ReviewEvent {
  final int prodId;
  OnGetListReviews({required this.prodId});
}
