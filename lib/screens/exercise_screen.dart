// exercise_solution_screen.dart
import 'package:exerapp/widgets/github_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exerapp/models/exercise.dart';

class ExerciseSolutionScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseSolutionScreen({
    super.key,
    required this.exercise,
  });

  @override
  State<ExerciseSolutionScreen> createState() => _ExerciseSolutionScreenState();
}

class _ExerciseSolutionScreenState extends State<ExerciseSolutionScreen> {
  bool _isFullScreen = false;

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen
          ? null
          : AppBar(
              title: Text(widget.exercise.title),
              actions: [
                GitHubIconButton(),
                IconButton(
                  icon: const Icon(Icons.fullscreen),
                  onPressed: _toggleFullScreen,
                  tooltip: 'Pantalla completa',
                ),
              ],
            ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(_isFullScreen ? 0 : 16),
          decoration: _isFullScreen
              ? null
              : BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
            borderRadius: BorderRadius.circular(_isFullScreen ? 0 : 12),
            child: Stack(
              children: [
                Center(child: widget.exercise.app),
                if (_isFullScreen)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.fullscreen_exit),
                      onPressed: _toggleFullScreen,
                      color: Colors.black54,
                      tooltip: 'Salir de pantalla completa',
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }
}
