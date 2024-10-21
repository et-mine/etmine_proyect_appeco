import 'package:etmine_design_appeco/molecules/em_button_action.dart';
import 'package:etmine_design_appeco/organisms/em_appbar.dart';
import 'package:etmine_proyect_appeco/core/utils/utils.dart';
import 'package:etmine_proyect_appeco/features/review/domain/entities/review.dart';
import 'package:etmine_proyect_appeco/features/review/presentation/bloc/review/review_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PgReviewAdd extends StatefulWidget {
  final int prodId;
  final int idRev;
  const PgReviewAdd({super.key, required this.prodId, required this.idRev});

  @override
  State<PgReviewAdd> createState() => _PgReviewAddState();
}

class _PgReviewAddState extends State<PgReviewAdd> {
  final formReviewKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController comentController = TextEditingController();

  bool submitReview() {
    if (formReviewKey.currentState!.validate()) {
      final userName = userNameController.text;
      final coment = comentController.text;

      Review addRev = Review(
          id: widget.idRev,
          idProduct: widget.prodId,
          userName: userName,
          cantStars: randomStar,
          comentReview: coment,
          userImgUrl: 'https://picsum.photos/$randomImage',
          timeReview: DateTime.now().toString());
      BlocProvider.of<ReviewBloc>(context).add(OnAddReview(review: addRev));

      userNameController.clear();
      comentController.clear();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EtMineAppBar(
          back: true,
          title: 'Review',
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formReviewKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(labelText: 'User name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: comentController,
                    decoration: InputDecoration(labelText: 'Coment'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  EtMineButtonAction(
                    textButton: 'Submit review',
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      if (submitReview()) {
                        await Future.delayed(Duration(milliseconds: 300));
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
