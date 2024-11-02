import 'package:exerapp/constants/songs.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerComplete extends StatefulWidget {
  const MusicPlayerComplete({super.key});

  @override
  State<MusicPlayerComplete> createState() => _MusicPlayerCompleteState();
}

class _MusicPlayerCompleteState extends State<MusicPlayerComplete> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentIndex = 0;
  bool _isPlaying = false;
  bool _isShuffleOn = false;
  RepeatMode _repeatMode = RepeatMode.off;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    // Configurar la lista de reproducción
    await _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children:
            playlist.map((song) => AudioSource.asset(song.asset)).toList(),
      ),
    );

    // Escuchar cambios en el estado de reproducción
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });

    // Escuchar cambios en el índice de la canción actual
    _audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        setState(() {
          _currentIndex = index;
        });
      }
    });
  }

  void _togglePlay() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  void _playNext() async {
    if (_currentIndex < playlist.length - 1) {
      await _audioPlayer.seekToNext();
    }
  }

  void _playPrevious() async {
    if (_currentIndex > 0) {
      await _audioPlayer.seekToPrevious();
    }
  }

  void _toggleShuffle() {
    setState(() {
      _isShuffleOn = !_isShuffleOn;
      _audioPlayer.setShuffleModeEnabled(_isShuffleOn);
    });
  }

  void _toggleRepeatMode() {
    setState(() {
      switch (_repeatMode) {
        case RepeatMode.off:
          _repeatMode = RepeatMode.one;
          _audioPlayer.setLoopMode(LoopMode.one);
          break;
        case RepeatMode.one:
          _repeatMode = RepeatMode.all;
          _audioPlayer.setLoopMode(LoopMode.all);
          break;
        case RepeatMode.all:
          _repeatMode = RepeatMode.off;
          _audioPlayer.setLoopMode(LoopMode.off);
          break;
      }
    });
  }

  @override
  void dispose() {
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
            Colors.purple.shade800,
            Colors.purple.shade500,
          ],
        ),
      ),
      child: Column(
        children: [
          // Área de la portada
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  playlist[_currentIndex].imageAsset,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Información de la canción
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              playlist[_currentIndex].title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Barra de progreso
          StreamBuilder<Duration?>(
            stream: _audioPlayer.durationStream,
            builder: (context, snapshot) {
              final duration = snapshot.data ?? Duration.zero;
              return StreamBuilder<Duration>(
                stream: _audioPlayer.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  return Column(
                    children: [
                      Slider(
                        value: position.inMilliseconds.toDouble(),
                        max: duration.inMilliseconds.toDouble(),
                        activeColor: Colors.white,
                        inactiveColor: Colors.white.withOpacity(0.3),
                        onChanged: (value) {
                          _audioPlayer.seek(
                            Duration(milliseconds: value.round()),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDuration(position),
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              _formatDuration(duration),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          // Controles de reproducción
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  _isShuffleOn ? Icons.shuffle : Icons.shuffle_outlined,
                  color: Colors.white,
                ),
                onPressed: _toggleShuffle,
              ),
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white),
                iconSize: 40,
                onPressed: _playPrevious,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.purple.shade800,
                  ),
                  iconSize: 50,
                  onPressed: _togglePlay,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white),
                iconSize: 40,
                onPressed: _playNext,
              ),
              IconButton(
                icon: Icon(
                  _getRepeatIcon(),
                  color: Colors.white,
                ),
                onPressed: _toggleRepeatMode,
              ),
            ],
          ),

          // Lista de canciones
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      playlist[index].imageAsset,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    playlist[index].title,
                    style: TextStyle(
                      color: _currentIndex == index
                          ? Colors.white
                          : Colors.white70,
                      fontWeight: _currentIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  onTap: () async {
                    await _audioPlayer.seek(Duration.zero, index: index);
                    await _audioPlayer.play();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  IconData _getRepeatIcon() {
    switch (_repeatMode) {
      case RepeatMode.off:
        return Icons.repeat;
      case RepeatMode.one:
        return Icons.repeat_one;
      case RepeatMode.all:
        return Icons.repeat;
      default:
        return Icons.repeat;
    }
  }
}

enum RepeatMode { off, one, all }
