class Review {
  int id;
  int idProduct;
  String userName;
  String? userImgUrl;
  String? timeReview;
  String comentReview;
  int? cantStars;

  Review(
      {required this.id,
      required this.idProduct,
      required this.userName,
      this.userImgUrl,
      this.timeReview,
      required this.comentReview,
      this.cantStars});
}
