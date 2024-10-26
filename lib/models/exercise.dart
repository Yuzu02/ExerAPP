// lib/models/exercise.dart
import 'package:flutter/material.dart';

enum ExerciseCategory {
  calculators,
  dataProcessing,
  games,
  utilities,
  visualization
}

extension CategoryExtension on ExerciseCategory {
  String get name {
    switch (this) {
      case ExerciseCategory.calculators:
        return 'Calculadoras';
      case ExerciseCategory.dataProcessing:
        return 'Procesamiento de Datos';
      case ExerciseCategory.games:
        return 'Juegos';
      case ExerciseCategory.utilities:
        return 'Utilidades';
      case ExerciseCategory.visualization:
        return 'Visualización';
    }
  }

  IconData get icon {
    switch (this) {
      case ExerciseCategory.calculators:
        return Icons.calculate;
      case ExerciseCategory.dataProcessing:
        return Icons.data_usage;
      case ExerciseCategory.games:
        return Icons.games;
      case ExerciseCategory.utilities:
        return Icons.build;
      case ExerciseCategory.visualization:
        return Icons.bar_chart;
    }
  }
}

class Exercise {
  final String id;
  final String title;
  final String description;
  final ExerciseCategory category;
  final Widget app;
  final String difficulty; // Agregado
  final List<String> tags; // Agregado
  final String codeUrl;
  final List<String> concepts;

  Exercise({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.app,
    required this.difficulty, // Agregado
    required this.tags, // Agregado
    this.codeUrl = '',
    required this.concepts,
  });
}
