// lib/screens/exercise_solution_screen.dart
import 'package:exerapp/models/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseSolutionScreen extends StatelessWidget {
  final Exercise exercise;
  final bool showCode;

  const ExerciseSolutionScreen({
    super.key,
    required this.exercise,
    this.showCode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.code),
            onPressed: () {
              // Implementar vista del código
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de información
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(exercise.category.icon),
                  const SizedBox(width: 8),
                  Text(
                    exercise.category.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Mini-app container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: exercise.app,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
