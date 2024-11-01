// lib/models/exercise.dart
import 'package:exerapp/models/exercise_category.dart';
import 'package:flutter/material.dart';

class Exercise {
  final String id;
  final String title;
  final String description;
  final ExerciseCategory category;
  final Widget app;
  final String difficulty;
  final List<String> tags;
  final List<String> concepts;

  Exercise({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.app,
    required this.difficulty,
    required this.tags,
    required this.concepts,
  });
}
