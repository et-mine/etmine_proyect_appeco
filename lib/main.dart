import 'package:etmine_proyect_appeco/app_eco.dart';
import 'package:etmine_proyect_appeco/getit.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const AppEco());
}
