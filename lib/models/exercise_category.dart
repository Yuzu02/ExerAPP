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
