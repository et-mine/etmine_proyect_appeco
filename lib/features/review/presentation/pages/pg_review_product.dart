import 'package:etmine_design_appeco/atoms/em_text.dart';
import 'package:etmine_design_appeco/fundation/em_colors.dart';
import 'package:etmine_design_appeco/molecules/em_cardreview.dart';
import 'package:etmine_design_appeco/organisms/em_appbar.dart';
import 'package:etmine_design_appeco/tokens/colors.dart';
import 'package:etmine_proyect_appeco/core/utils/utils.dart';
import 'package:etmine_proyect_appeco/features/review/presentation/bloc/review/review_bloc.dart';
import 'package:etmine_proyect_appeco/features/review/presentation/pages/pg_review_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PgReviewProduct extends StatefulWidget {
  const PgReviewProduct({super.key});

  @override
  State<PgReviewProduct> createState() => _PgReviewProductState();
}

class _PgReviewProductState extends State<PgReviewProduct> {
  late int prodId;
  late int nuevoIdRev;

  @override
  void initState() {
    super.initState();
    prodId = randomPostId;
  }

  void deleteItem(int index, int idProduct) {
    BlocProvider.of<ReviewBloc>(context)
        .add(OnDeleteReview(idReview: index, idProduct: idProduct));
  }

  void showDeleteConfirmationDialog(int index, int idProduct) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete review'),
          content: Text('Do you want to delete this review?'),
          actions: [
            TextButton(
              onPressed: () {
                deleteItem(index, idProduct);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReviewBloc>(context).add(OnGetListReviews(prodId: prodId));
    return Scaffold(
      appBar: const EtMineAppBar(
        title: 'Review Product',
        iconTexto: Icon(
          Icons.star,
          color: starReviewIn,
          size: 20,
        ),
        textoIcono: '4.6',
      ),
      body: BlocBuilder<ReviewBloc, ReviewState>(builder: (ctx, state) {
        switch (state) {
          case ReviewLoading():
            return const Center(child: CircularProgressIndicator());
          case ReviewInitial():
            return Center(
              child: H1(text: 'ReviewInitial.'),
            );
          case ReviewList():
            nuevoIdRev = state.reviews
                    .reduce(
                        (actual, next) => actual.id > next.id ? actual : next)
                    .id +
                1;

            if (state.reviews.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: screenHeight(context),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: state.reviews
                            .map((p) => Column(
                                  children: [
                                    GestureDetector(
                                      onLongPress: () {
                                        showDeleteConfirmationDialog(
                                            p.id, p.idProduct);
                                      },
                                      child: EtMineCardReview(
                                        textTitle: p.userName,
                                        textDetail: p.comentReview,
                                        imgPrincipal: p.userImgUrl ?? '',
                                        cantStars: p.cantStars ?? 0,
                                        textTool: p.timeReview ?? '',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: H1(text: 'No reviews'),
              );
            }

          case ReviewAddSuccess():
            return Center(
              child: H1(text: 'ReviewAddSuccess.'),
            );
          case ReviewDeleteSuccess():
            return Center(
              child: H1(text: 'ReviewDeleteSuccess.'),
            );
          case ReviewFailure():
            return Center(
              child: H1(text: 'Ocurrió un error.'),
            );
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.message,
          color: brandPrimary,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PgReviewAdd(
                      idRev: nuevoIdRev,
                      prodId: prodId,
                    )),
          );
        },
      ),
    );
  }
}
