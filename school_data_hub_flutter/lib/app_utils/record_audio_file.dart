import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

/// Shows a dialog that records audio from the microphone.
/// Returns the recorded [File] or `null` if the user cancelled.
Future<({File? file, String? fileInfo})?> recordAudioFile(
  BuildContext context,
) {
  return showDialog<({File? file, String? fileInfo})>(
    context: context,
    barrierDismissible: false,
    builder: (context) => const _AudioRecordDialog(),
  );
}

enum _RecordState { idle, recording, done }

class _AudioRecordDialog extends StatefulWidget {
  const _AudioRecordDialog();

  @override
  State<_AudioRecordDialog> createState() => _AudioRecordDialogState();
}

class _AudioRecordDialogState extends State<_AudioRecordDialog> {
  final AudioRecorder _recorder = AudioRecorder();
  _RecordState _state = _RecordState.idle;
  Duration _elapsed = Duration.zero;
  Timer? _timer;
  String? _filePath;
  String? _errorMessage;

  @override
  void dispose() {
    _timer?.cancel();
    _recorder.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      setState(() {
        _errorMessage = 'Mikrofonberechtigung wurde nicht erteilt.';
      });
      return;
    }

    final tempDir = await getTemporaryDirectory();
    final filePath = p.join(
      tempDir.path,
      'recording_${DateTime.now().millisecondsSinceEpoch}.m4a',
    );

    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: filePath,
    );

    _filePath = filePath;
    _elapsed = Duration.zero;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _elapsed += const Duration(seconds: 1);
      });
    });

    setState(() {
      _state = _RecordState.recording;
      _errorMessage = null;
    });
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    final path = await _recorder.stop();

    if (path != null) {
      _filePath = path;
    }

    setState(() {
      _state = _RecordState.done;
    });
  }

  void _cancel() {
    // Clean up temp file if it exists
    if (_filePath != null) {
      final file = File(_filePath!);
      if (file.existsSync()) {
        file.deleteSync();
      }
    }
    Navigator.of(context).pop();
  }

  void _confirm() {
    if (_filePath != null) {
      Navigator.of(
        context,
      ).pop((file: File(_filePath!), fileInfo: _formatDuration(_elapsed)));
    }
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Audio aufnehmen'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _buildStateContent(),
          ),
        ],
      ),
      actions: _buildActions(),
    );
  }

  Widget _buildStateContent() {
    switch (_state) {
      case _RecordState.idle:
        return Column(
          key: const ValueKey('idle'),
          children: [
            Icon(
              Icons.mic,
              size: 48,
              color: AppColors.interactiveColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 8),
            const Text('Tippen Sie auf Aufnahme, um zu starten.'),
          ],
        );
      case _RecordState.recording:
        return Column(
          key: const ValueKey('recording'),
          children: [
            const Icon(Icons.mic, size: 48, color: Colors.red),
            const SizedBox(height: 8),
            Text(
              _formatDuration(_elapsed),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Aufnahme läuft...',
              style: TextStyle(color: Colors.red),
            ),
          ],
        );
      case _RecordState.done:
        return Column(
          key: const ValueKey('done'),
          children: [
            Icon(Icons.check_circle, size: 48, color: Colors.green.shade600),
            const SizedBox(height: 8),
            Text(
              _formatDuration(_elapsed),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('Aufnahme fertig.'),
          ],
        );
    }
  }

  List<Widget> _buildActions() {
    switch (_state) {
      case _RecordState.idle:
        return [
          TextButton(onPressed: _cancel, child: const Text('Abbrechen')),
          ElevatedButton.icon(
            onPressed: _startRecording,
            icon: const Icon(Icons.mic),
            label: const Text('Aufnahme'),
          ),
        ];
      case _RecordState.recording:
        return [
          TextButton(onPressed: _cancel, child: const Text('Abbrechen')),
          ElevatedButton.icon(
            onPressed: _stopRecording,
            icon: const Icon(Icons.stop),
            label: const Text('Stopp'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ];
      case _RecordState.done:
        return [
          TextButton(onPressed: _cancel, child: const Text('Verwerfen')),
          ElevatedButton.icon(
            onPressed: _confirm,
            icon: const Icon(Icons.check),
            label: const Text('Speichern'),
          ),
        ];
    }
  }
}
