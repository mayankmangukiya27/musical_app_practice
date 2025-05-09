import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shimmer/shimmer.dart';
import '../core/database/database_models/song_model.dart';

class SongDetailScreen extends StatefulWidget {
  final Song song;

  const SongDetailScreen({super.key, required this.song});

  @override
  State<SongDetailScreen> createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen> {
  late AudioPlayer _audioPlayer;
  bool _isAudioReady = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  bool _hasEnded = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setupAudio();
  }

  Future<void> _setupAudio() async {
    try {
      if (widget.song.audioUrl != null && widget.song.audioUrl!.isNotEmpty) {
        await _audioPlayer.setUrl(widget.song.audioUrl!);
        _duration = _audioPlayer.duration ?? Duration.zero;

        _positionSubscription = _audioPlayer.positionStream.listen((pos) {
          if (!_hasEnded) {
            setState(() {
              _position = pos;
            });
          }
        });

        _playerStateSubscription = _audioPlayer.playerStateStream.listen((
          state,
        ) {
          if (state.processingState == ProcessingState.completed) {
            setState(() {
              _hasEnded = true;
              _position = Duration.zero;
            });
            _audioPlayer.pause();
          }
        });

        setState(() {
          _isAudioReady = true;
        });
      }
    } catch (e) {
      debugPrint('Audio setup error: $e');
    }
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlayback(PlayerState state) async {
    if (_hasEnded) {
      await _audioPlayer.seek(Duration.zero);
      _hasEnded = false;
      await _audioPlayer.play();
    } else if (state.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    final song = widget.song;

    return Scaffold(
      appBar: AppBar(
        title: Text("Player", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Listening To",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(height: 18),
            Center(
              child: Material(
                elevation: 12,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: song.imageUrl,
                  width: 330,
                  height: 330,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey,
                          width: 330,
                          height: 330,
                        ),
                      ),
                  errorWidget:
                      (context, url, error) => const Icon(Icons.broken_image),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(song.title, style: Theme.of(context).textTheme.titleMedium),
            Text(
              '👤 ${song.artist}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            if (song.album != null)
              Text(
                '💿 ${song.album}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            if (song.releaseDate != null)
              Text(
                '📅 ${song.releaseDate}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            const SizedBox(height: 24),

            if (_isAudioReady)
              StreamBuilder<PlayerState>(
                stream: _audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  final isPlaying = state?.playing ?? false;
                  final processingState = state?.processingState;

                  final showLoading =
                      processingState == ProcessingState.loading ||
                      processingState == ProcessingState.buffering;

                  return Column(
                    children: [
                      Slider(
                        padding: EdgeInsets.only(left: 3, right: 3),
                        value: _position.inSeconds.toDouble(),
                        min: 0.0,
                        max: _duration.inSeconds.toDouble().clamp(
                          1.0,
                          double.infinity,
                        ),

                        onChanged: (value) {
                          final newPosition = Duration(seconds: value.toInt());
                          _audioPlayer.seek(newPosition);
                          setState(() {
                            _position = newPosition;
                            _hasEnded = false;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(_position),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            _formatDuration(_duration),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      /*  Text(
                        "${_formatDuration(_position)} / ${_formatDuration(_duration)}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ), */
                      const SizedBox(height: 12),

                      GestureDetector(
                        onTap:
                            showLoading ? null : () => _togglePlayback(state!),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            showLoading
                                ? Icons.hourglass_top
                                : isPlaying && !_hasEnded
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                      ),
                      /*  ElevatedButton.icon(
                        icon: Icon(
                          showLoading
                              ? Icons.hourglass_top
                              : isPlaying && !_hasEnded
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 30,
                        ),
                        label: Text(
                          showLoading
                              ? 'Loading...'
                              : isPlaying && !_hasEnded
                              ? 'Pause'
                              : _hasEnded
                              ? 'Replay'
                              : 'Play',
                        ),
                        onPressed:
                            showLoading ? null : () => _togglePlayback(state!),
                      ), */
                    ],
                  );
                },
              )
            else
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
