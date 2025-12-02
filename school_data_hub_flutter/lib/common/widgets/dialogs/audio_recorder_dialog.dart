import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioRecorderDialog extends StatefulWidget {
  const AudioRecorderDialog({super.key});

  @override
  State<AudioRecorderDialog> createState() => _AudioRecorderDialogState();
}

class _AudioRecorderDialogState extends State<AudioRecorderDialog> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isRecording = false;
  bool _isPlaying = false;
  String? _recordedFilePath;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying =
              state.playing &&
              state.processingState != ProcessingState.completed;
        });
      }
    });
  }

  Future<void> _requestPermission() async {
    await _audioRecorder.hasPermission();
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final directory = await getTemporaryDirectory();
        final filePath =
            '${directory.path}/temp_audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(const RecordConfig(), path: filePath);

        setState(() {
          _isRecording = true;
          _recordedFilePath = null;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _recordedFilePath = path;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _playRecording() async {
    if (_recordedFilePath != null) {
      await _audioPlayer.setFilePath(_recordedFilePath!);
      await _audioPlayer.play();
    }
  }

  Future<void> _stopPlayback() async {
    await _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Audio aufnehmen'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isRecording)
            const Text(
              'Aufnahme läuft...',
              style: TextStyle(color: Colors.red),
            ),
          if (_recordedFilePath != null && !_isRecording)
            const Text('Aufnahme fertig'),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_isRecording && _recordedFilePath == null)
                IconButton(
                  icon: const Icon(Icons.mic, size: 40, color: Colors.red),
                  onPressed: _startRecording,
                ),
              if (_isRecording)
                IconButton(
                  icon: const Icon(Icons.stop, size: 40),
                  onPressed: _stopRecording,
                ),
              if (_recordedFilePath != null && !_isRecording)
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.stop : Icons.play_arrow,
                    size: 40,
                  ),
                  onPressed: _isPlaying ? _stopPlayback : _playRecording,
                ),
              if (_recordedFilePath != null && !_isRecording)
                IconButton(
                  icon: const Icon(Icons.delete, size: 30),
                  onPressed: () {
                    setState(() {
                      _recordedFilePath = null;
                    });
                  },
                ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: _recordedFilePath != null
              ? () {
                  Navigator.of(context).pop(File(_recordedFilePath!));
                }
              : null,
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}

Future<File?> showAudioRecorderDialog(BuildContext context) {
  return showDialog<File?>(
    context: context,
    builder: (context) => const AudioRecorderDialog(),
  );
}
