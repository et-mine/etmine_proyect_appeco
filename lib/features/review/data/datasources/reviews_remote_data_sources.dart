import 'package:dio/dio.dart';
import 'package:etmine_proyect_appeco/features/review/data/models/review_model.dart';

abstract class ReviewsRemoteDataSources {
  Future<List<ReviewModel>> getReviewsList(int id);
}

class ReviewsRemoteDataSourcesImpl implements ReviewsRemoteDataSources {
  final Dio dio = Dio();

  @override
  Future<List<ReviewModel>> getReviewsList(int id) async {
    final resp = await dio
        .get('https://jsonplaceholder.typicode.com/comments?postId=$id');

    return ReviewModel.fromJsonList(resp.data);
  }
}
