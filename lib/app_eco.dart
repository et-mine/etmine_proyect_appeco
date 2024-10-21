import 'package:etmine_proyect_appeco/features/review/presentation/bloc/review/review_bloc.dart';
import 'package:etmine_proyect_appeco/features/review/presentation/pages/pg_prouct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AppEco extends StatelessWidget {
  const AppEco({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => GetIt.instance.get<ReviewBloc>())
        ],
        child: MaterialApp(
          title: 'App Eco',
          debugShowCheckedModeBanner: false,
          home: const PgProduct(),
        ));
  }
}
