// exercise_solution_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
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

  Future<void> _openGitHub() async {
    final Uri url = Uri.parse('https://github.com/Yuzu02/exerapp');
    try {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se pudo abrir el repositorio'),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al abrir el repositorio'),
          ),
        );
      }
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
                IconButton(
                  icon: const Icon(Icons.code_outlined),
                  onPressed: _openGitHub,
                  tooltip: 'Ver código en GitHub',
                ),
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
