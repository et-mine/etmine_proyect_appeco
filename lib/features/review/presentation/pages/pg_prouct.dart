import 'package:etmine_design_appeco/atoms/em_text.dart';
import 'package:etmine_proyect_appeco/features/review/presentation/pages/pg_review_product.dart';
import 'package:flutter/material.dart';

class PgProduct extends StatefulWidget {
  const PgProduct({super.key});

  @override
  State<PgProduct> createState() => _PgProductState();
}

class _PgProductState extends State<PgProduct> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => PgReviewProduct()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            H1(text: 'Welcome to App Eco'),
            SubTitle(text: 'You will be redirected to reviews')
          ],
        ),
      ),
    );
  }
}
