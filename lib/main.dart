import 'package:exerapp/provider/exercise_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExerciseProvider(),
      child: MaterialApp(
        title: 'Biblioteca de Ejercicios',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const HomeScreen(),
      ),
    );
  }
}
