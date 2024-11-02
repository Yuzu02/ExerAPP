import 'package:exerapp/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _shortAudioPlayer = AudioPlayer();
  final AudioPlayer _longAudioPlayer = AudioPlayer();
  bool _isLongPlaying = false;

  @override
  void initState() {
    super.initState();
    _initAudioPlayers();
  }

  Future<void> _initAudioPlayers() async {
    try {
      await Future.wait([
        _shortAudioPlayer.setAsset('assets/sound/sound_short.mp3'),
        _longAudioPlayer.setAsset('assets/sound/sound_long.mp3')
      ]);

      _shortAudioPlayer.setLoopMode(LoopMode.off);

      // Monitoreamos el estado de reproducción
      _longAudioPlayer.playingStream.listen((playing) {
        setState(() => _isLongPlaying = playing);
      });

      // Monitoreamos cuando termina la reproducción
      _longAudioPlayer.processingStateStream.listen((state) {
        if (state == ProcessingState.completed) {
          setState(() => _isLongPlaying = false);
        }
      });
    } catch (e) {
      showToast('Error al inicializar los reproductores de audio');
    }
  }

  Future<void> _playShortAudio() async {
    try {
      if (_isLongPlaying) {
        await _longAudioPlayer.pause();
      }

      await _shortAudioPlayer.seek(Duration.zero);
      await _shortAudioPlayer.play();
      showToast('Reproduciendo audio corto');
    } catch (e) {
      showToast('Error al reproducir audio corto');
    }
  }

  Future<void> _toggleLongAudio() async {
    try {
      if (_isLongPlaying) {
        await _longAudioPlayer.pause();
        showToast('Audio largo pausado');
      } else {
        if (_shortAudioPlayer.playing) {
          await _shortAudioPlayer.pause();
        }

        // Si está al inicio o terminado, empezamos desde el principio
        if (_longAudioPlayer.position == Duration.zero ||
            _longAudioPlayer.processingState == ProcessingState.completed) {
          await _longAudioPlayer.seek(Duration.zero);
        }

        await _longAudioPlayer.play();
        showToast('Reproduciendo audio largo');
      }
    } catch (e) {
      showToast('Error al manejar audio largo');
    }
  }

  @override
  void dispose() {
    _shortAudioPlayer.dispose();
    _longAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple.shade300,
            Colors.deepPurple.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Reproductor de Audio',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          _AudioButton(
            icon: Icons.music_note,
            label: 'Audio Corto',
            onPressed: _playShortAudio,
            isPlaying: false,
          ),
          const SizedBox(height: 20),
          StreamBuilder<bool>(
            stream: _longAudioPlayer.playingStream,
            builder: (context, snapshot) {
              final isPlaying = snapshot.data ?? false;
              return _AudioButton(
                icon: isPlaying ? Icons.stop : Icons.queue_music,
                label: isPlaying ? 'Detener' : 'Audio Largo',
                onPressed: _toggleLongAudio,
                isPlaying: isPlaying,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AudioButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isPlaying;

  const _AudioButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        backgroundColor: isPlaying ? Colors.red.shade400 : Colors.white,
        foregroundColor: isPlaying ? Colors.white : Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
