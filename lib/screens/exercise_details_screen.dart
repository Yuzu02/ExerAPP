//
// lib/screens/exercise_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/exercise.dart';
import 'exercise_screen.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              width: double.infinity,
              height: 200,
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Icon(
                exercise.category.icon,
                size: 64,
                color: Theme.of(context).primaryColor,
              ),
            ),

            // Contenido
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categoría y dificultad
                  Row(
                    children: [
                      Chip(
                        avatar: Icon(exercise.category.icon, size: 16),
                        label: Text(exercise.category.name),
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(exercise.difficulty),
                        backgroundColor:
                            _getDifficultyColor(exercise.difficulty),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Descripción
                  const Text(
                    'Descripción',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(exercise.description),
                  const SizedBox(height: 16),

                  // Conceptos
                  const Text(
                    'Conceptos utilizados',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: exercise.concepts
                        .map((concept) => Chip(label: Text(concept)))
                        .toList(),
                  ),
                  const SizedBox(height: 24),

                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: exercise.tags
                        .map((tag) => Chip(
                              label: Text('#$tag'),
                              backgroundColor: Colors.grey[200],
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 24),

                  // Botón para ver solución
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ExerciseSolutionScreen(
                              exercise: exercise,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Ver solución',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'fácil':
        return Colors.green[100]!;
      case 'intermedio':
        return Colors.orange[100]!;
      case 'difícil':
        return Colors.red[100]!;
      default:
        return Colors.grey[100]!;
    }
  }
}
