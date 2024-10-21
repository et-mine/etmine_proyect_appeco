import 'package:etmine_proyect_appeco/core/error/failures.dart';
import 'package:etmine_proyect_appeco/features/review/data/models/review_model.dart';
import 'package:etmine_proyect_appeco/features/review/domain/entities/review.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ReviewsLocalDataResources {
  Future<int> addReview(Review review);
  Future<bool> deleteReview(int idReview);
  Future<List<ReviewModel>> getReviewsList(int id);
}

class HiveReviewsLocalDataResourcesImpl implements ReviewsLocalDataResources {
  HiveReviewsLocalDataResourcesImpl();

  @override
  Future<int> addReview(Review review) async {
    try {
      Box<dynamic> box = await Hive.openBox('reviews');
      box.put(review.id, ReviewModel.fromEntity(review).toJson());
      return review.id;
    } catch (error) {
      debugPrint(error.toString());
      throw LocalFailure();
    }
  }

  @override
  Future<bool> deleteReview(int idReview) async {
    try {
      Box<dynamic> box = await Hive.openBox('reviews');
      await box.delete(idReview);
      return true;
    } catch (error) {
      debugPrint(error.toString());
      throw LocalFailure();
    }
  }

  @override
  Future<List<ReviewModel>> getReviewsList(int id) async {
    try {
      Box<dynamic> box = await Hive.openBox('reviews');
      return box.values.map((p) => ReviewModel.fromJsonComplete(p)).toList();
    } catch (error) {
      debugPrint(error.toString());
      throw LocalFailure();
    }
  }
}
