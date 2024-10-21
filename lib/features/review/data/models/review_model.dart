import 'package:etmine_proyect_appeco/features/review/domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel(
      {required super.id,
      required super.idProduct,
      required super.userName,
      super.userImgUrl,
      super.timeReview,
      required super.comentReview,
      super.cantStars});

  factory ReviewModel.fromJson(json) {
    return ReviewModel(
      id: json['id'],
      idProduct: 0,
      userName: json['email'],
      comentReview: json['body'],
    );
  }

  static List<ReviewModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ReviewModel.fromJson(json)).toList();
  }

  factory ReviewModel.fromJsonComplete(json) {
    return ReviewModel(
      id: json['id'],
      idProduct: json['idProduct'],
      userName: json['userName'],
      userImgUrl: json['userImgUrl'],
      timeReview: json['timeReview'],
      comentReview: json['comentReview'],
      cantStars: json['cantStars'],
    );
  }

  factory ReviewModel.fromEntity(Review review) {
    return ReviewModel(
        id: review.id,
        idProduct: review.idProduct,
        userName: review.userName,
        userImgUrl: review.userImgUrl,
        timeReview: review.timeReview,
        comentReview: review.comentReview,
        cantStars: review.cantStars);
  }

  static List<ReviewModel> fromEntityList(List<dynamic> jsonList) {
    return jsonList.map((json) => ReviewModel.fromJsonComplete(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idProduct': idProduct,
      'userName': userName,
      'userImgUrl': userImgUrl,
      'timeReview': timeReview,
      'comentReview': comentReview,
      'cantStars': cantStars,
    };
  }
}
