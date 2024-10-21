import 'dart:math';

import 'package:etmine_proyect_appeco/features/review/domain/entities/review.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

int get randomPostId => Random().nextInt(100) + 1;
int get randomImage => Random().nextInt(200) + 1;
int get randomStar => Random().nextInt(4) + 1;

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double statusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return (screenSize(context).height -
          kToolbarHeight -
          statusBarHeight(context)) /
      dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

List<Review> convertTimeAgoReviewList(List<Review> listReviews) {
  List<Review> listReviewsUpd = [];
  listReviews.sort((a, b) {
    DateTime dateA = DateTime.parse(a.timeReview ?? DateTime.now().toString());
    DateTime dateB = DateTime.parse(b.timeReview ?? DateTime.now().toString());
    return dateB.compareTo(dateA);
  });
  for (var review in listReviews) {
    DateTime fecha = DateTime.parse(review.timeReview ?? '');
    String tiempoTranscurrido = timeago.format(fecha);
    Review reviewUpd = review;
    reviewUpd.timeReview = tiempoTranscurrido;
    listReviewsUpd.add(reviewUpd);
  }
  return listReviewsUpd;
}
