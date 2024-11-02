import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderWidget extends StatefulWidget {
  const AudioRecorderWidget({super.key});

  @override
  State<AudioRecorderWidget> createState() => _AudioRecorderWidgetState();
}

class _AudioRecorderWidgetState extends State<AudioRecorderWidget>
    with SingleTickerProviderStateMixin {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _hasPermissions = false;
  bool _isRecording = false;
  bool _isPaused = false;
  bool _isPlaying = false;
  String? _recordedFilePath;
  Timer? _timer;
  Duration _recordingDuration = Duration.zero;
  final List<double> _audioWaveforms = [];
  late AnimationController _waveformController;
  final List<double> _playbackWaveforms = [];
  StreamSubscription? _recorderSubscription;
  Duration _playbackPosition = Duration.zero;
  Duration _playbackDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
    _waveformController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    )..repeat(reverse: true);
  }

  Future<void> _initializeRecorder() async {
    _hasPermissions = await _checkAndRequestPermissions();

    if (!_hasPermissions) {
      _showToast("No se pudieron obtener los permisos necesarios");
      return;
    }

    await _recorder.openRecorder();
    await _recorder.setSubscriptionDuration(const Duration(milliseconds: 100));

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _playbackDuration = duration);
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() => _playbackPosition = position);
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying = false;
        _playbackPosition = Duration.zero;
      });
    });
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<bool> _checkAndRequestPermissions() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) return false;

    if (Platform.isAndroid) {
      final storageStatus = await Permission.storage.request();
      if (storageStatus != PermissionStatus.granted) return false;
    }

    return true;
  }

  Future<void> _startRecording() async {
    if (!_hasPermissions) {
      _hasPermissions = await _checkAndRequestPermissions();
      if (!_hasPermissions) {
        _showToast(
            "No se pueden iniciar la grabación sin los permisos necesarios");
        return;
      }
    }

    try {
      final dir = await getTemporaryDirectory();
      _recordedFilePath = '${dir.path}/recorded_audio.aac';

      await _recorder.startRecorder(
        toFile: _recordedFilePath,
        codec: Codec.aacADTS,
      );

      setState(() {
        _isRecording = true;
        _audioWaveforms.clear();
        _recordingDuration = Duration.zero;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _recordingDuration += const Duration(seconds: 1);
        });
      });

      _startWaveformMonitoring();
    } catch (e) {
      debugPrint('Error al iniciar la grabación: $e');
      _showToast("Error al iniciar la grabación");
    }
  }

  void _startWaveformMonitoring() {
    _recorderSubscription?.cancel();
    _recorderSubscription = _recorder.onProgress?.listen((e) {
      final decibels = e.decibels ?? 0;
      // Normalizar los decibelios a un valor entre 0 y 1
      final normalized = (decibels + 160) / 160;
      setState(() {
        _audioWaveforms.add(normalized.clamp(0.0, 1.0));
        if (_audioWaveforms.length > 50) {
          _audioWaveforms.removeAt(0);
        }
      });
        });
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    _recorderSubscription?.cancel();
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
      _isPaused = false;
    });
  }

  Future<void> _togglePauseRecording() async {
    if (_isPaused) {
      await _recorder.resumeRecorder();
      _startWaveformMonitoring();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _recordingDuration += const Duration(seconds: 1);
        });
      });
    } else {
      await _recorder.pauseRecorder();
      _recorderSubscription?.cancel();
      _timer?.cancel();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  Future<void> _playRecording() async {
    if (_recordedFilePath != null) {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play(DeviceFileSource(_recordedFilePath!));
      }
      setState(() {
        _isPlaying = !_isPlaying;
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _waveformController.dispose();
    _timer?.cancel();
    _recorderSubscription?.cancel();
    _recorder.closeRecorder();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade900,
            Colors.blue.shade600,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatDuration(
                _isRecording ? _recordingDuration : _playbackPosition),
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AnimatedBuilder(
              animation: _waveformController,
              builder: (context, child) {
                return CustomPaint(
                  painter: WaveformPainter(
                    waveforms:
                        _isRecording ? _audioWaveforms : _playbackWaveforms,
                    animationValue: _waveformController.value,
                    isRecording: _isRecording,
                  ),
                  size: Size.infinite,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_recordedFilePath != null && !_isRecording)
                FloatingActionButton(
                  onPressed: _playRecording,
                  backgroundColor: Colors.white,
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.blue.shade900,
                    size: 32,
                  ),
                ),
              const SizedBox(width: 20),
              FloatingActionButton.large(
                onPressed: _isRecording ? _stopRecording : _startRecording,
                backgroundColor: _isRecording ? Colors.red : Colors.white,
                child: Icon(
                  _isRecording ? Icons.stop : Icons.mic,
                  color: _isRecording ? Colors.white : Colors.blue.shade900,
                  size: 36,
                ),
              ),
              const SizedBox(width: 20),
              if (_isRecording)
                FloatingActionButton(
                  onPressed: _togglePauseRecording,
                  backgroundColor: Colors.white,
                  child: Icon(
                    _isPaused ? Icons.play_arrow : Icons.pause,
                    color: Colors.blue.shade900,
                    size: 32,
                  ),
                ),
            ],
          ),
          if (_recordedFilePath != null && !_isRecording)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 8,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 16,
                      ),
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white.withOpacity(0.3),
                      thumbColor: Colors.white,
                      overlayColor: Colors.white.withOpacity(0.3),
                    ),
                    child: Slider(
                      value: _playbackPosition.inMilliseconds.toDouble(),
                      max: _playbackDuration.inMilliseconds.toDouble(),
                      onChanged: (value) {
                        _audioPlayer
                            .seek(Duration(milliseconds: value.round()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_playbackPosition),
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          _formatDuration(_playbackDuration),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final List<double> waveforms;
  final double animationValue;
  final bool isRecording;

  WaveformPainter({
    required this.waveforms,
    required this.animationValue,
    required this.isRecording,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final width = size.width;
    final height = size.height;
    final centerY = height / 2;

    if (waveforms.isEmpty) {
      canvas.drawLine(
        Offset(0, centerY),
        Offset(width, centerY),
        paint..color = Colors.white.withOpacity(0.3),
      );
      return;
    }

    final spacing = width / (waveforms.length - 1);

    for (int i = 0; i < waveforms.length; i++) {
      final x = i * spacing;
      final waveformHeight = waveforms[i] * height / 2;
      final amplitude = isRecording
          ? waveformHeight * (1 + math.sin(animationValue * math.pi) * 0.3)
          : waveformHeight;

      canvas.drawLine(
        Offset(x, centerY - amplitude),
        Offset(x, centerY + amplitude),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(WaveformPainter oldDelegate) =>
      animationValue != oldDelegate.animationValue ||
      waveforms != oldDelegate.waveforms;
}
