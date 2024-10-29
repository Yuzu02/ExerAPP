// lib/providers/exercise_provider.dart
import 'package:exerapp/exercise/calculator_app.dart';
import 'package:exerapp/exercise/ciclo_activity.dart';
import 'package:exerapp/exercise/list_view.dart';
import 'package:exerapp/exercise/promedio.dart';
import 'package:exerapp/exercise/radio_button.dart';
import 'package:exerapp/exercise/sumar.dart';
import 'package:exerapp/models/exercise.dart';
import 'package:exerapp/screens/extra/url_input_screen.dart';
import 'package:flutter/foundation.dart';

class ExerciseProvider with ChangeNotifier {
  final List<Exercise> _exercises = [
    Exercise(
      id: '1',
      title: 'Calculadora Básica',
      description:
          'Una calculadora con operaciones básicas: suma, resta, multiplicación y división.',
      category: ExerciseCategory.calculators,
      app: const CalculatorApp(),
      concepts: [
        'Widgets Stateful',
        'Manejo de eventos',
        'Operaciones matemáticas'
      ],
      difficulty: 'Fácil',
      tags: ['Calculadora', 'Básico'],
    ),
    Exercise(
        id: '2',
        title: "Ciclo de vida de un activity",
        description: "Muestra los estados de un widget en Flutter",
        category: ExerciseCategory.utilities,
        app: const LifeCycleExample(),
        difficulty: "Intermedio",
        tags: ["Ciclo de vida", "StatefulWidget"],
        concepts: ["initState", "didChangeDependencies", "dispose"]),
    Exercise(
        id: '3',
        title: "List View",
        description: "Usa un ListView para mostrar una lista de elementos",
        category: ExerciseCategory.utilities,
        app: const CustomListView(),
        difficulty: "Fácil",
        tags: ["ListView", "StatelessWidget"],
        concepts: ["ListView", "ListTile"]),
    Exercise(
        id: "4",
        title: "webview",
        description: "Muestra una página web en tu aplicación",
        category: ExerciseCategory.utilities,
        app: const UrlInputScreen(),
        difficulty: "Intermedio",
        tags: ["WebView", "StatefulWidget"],
        concepts: ["webview", "webview_flutter"]),
    Exercise(
        id: '5',
        title: 'Sumar',
        description: 'Suma dos números',
        category: ExerciseCategory.calculators,
        app: const SumWidget(),
        difficulty: 'Fácil',
        tags: ['Suma', 'Básico'],
        concepts: ['StatefulWidget', 'TextField', 'SnackBar']),
    Exercise(
        id: '6',
        title: 'Promedio Estudiante',
        description: 'Calcula el promedio de tres calificaciones',
        category: ExerciseCategory.calculators,
        app: const StudentStatusWidget(),
        difficulty: 'Fácil',
        tags: ['Promedio', 'Básico'],
        concepts: ['StatefulWidget', 'TextField', 'SnackBar']),
    Exercise(
        id: '7',
        title: 'RadioButton',
        description: 'Calcula la suma o resta de dos números',
        category: ExerciseCategory.calculators,
        app: const RadioButtonWidget(),
        difficulty: 'Fácil',
        tags: ['RadioButton', 'Básico'],
        concepts: ['StatefulWidget', 'TextField', 'SnackBar', 'Radio']),
    // Añade  más ejercicios aquí
  ];

  List<Exercise> get exercises => _exercises;

  List<Exercise> searchExercises(
      String query, ExerciseCategory? selectedCategory) {
    return _exercises.where((exercise) {
      bool matchesQuery = exercise.title
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          exercise.description.toLowerCase().contains(query.toLowerCase()) ||
          exercise.concepts.any(
              (concept) => concept.toLowerCase().contains(query.toLowerCase()));

      bool matchesCategory =
          selectedCategory == null || exercise.category == selectedCategory;

      return matchesQuery && matchesCategory;
    }).toList();
  }
}
