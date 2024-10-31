// lib/providers/exercise_provider.dart
import 'package:flutter/foundation.dart';
import 'exercise_list.dart';
import 'package:exerapp/models/exercise.dart';

class ExerciseProvider with ChangeNotifier {
  List<Exercise> get exercises => exerciseList;

  List<Exercise> searchExercises(
      String query, ExerciseCategory? selectedCategory) {
    return exerciseList.where((exercise) {
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
