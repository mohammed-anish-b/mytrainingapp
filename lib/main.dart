import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/presentation/common/app_theme.dart';
import 'package:training/presentation/common/ui_string.dart';
import 'package:training/presentation/screens/home/home.dart';
import 'package:training/provider/training_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: UIString.myTrainingsApp,
      theme: AppTheme.lightThemeData,
      home: ChangeNotifierProvider(
        create: (context) => TrainingProvider(),
        child: const Home(),
      ),
    );
  }
}
