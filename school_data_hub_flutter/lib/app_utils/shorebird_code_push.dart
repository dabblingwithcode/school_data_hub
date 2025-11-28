import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/bottom_nav_bar_no_filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

final _log = Logger('CheckForUpdatesPage');

class CheckForUpdatesPage extends StatefulWidget {
  const CheckForUpdatesPage({super.key});

  @override
  State<CheckForUpdatesPage> createState() => _CheckForUpdatesPageState();
}

class _CheckForUpdatesPageState extends State<CheckForUpdatesPage> {
  final _updater = ShorebirdUpdater();
  late final bool _isUpdaterAvailable;
  var _currentTrack = UpdateTrack.stable;
  var _isCheckingForUpdates = false;
  Patch? _currentPatch;

  @override
  void initState() {
    super.initState();
    // Check whether Shorebird is available.
    setState(() => _isUpdaterAvailable = _updater.isAvailable);

    // Read the current patch (if there is one.)
    // `currentPatch` will be `null` if no patch is installed.
    _updater
        .readCurrentPatch()
        .then((currentPatch) {
          setState(() => _currentPatch = currentPatch);
        })
        .catchError((Object error) {
          // If an error occurs, we log it for now.
          _log.severe('Error reading current patch: $error');
        });
  }

  Future<void> _checkForUpdate() async {
    if (_isCheckingForUpdates) return;

    try {
      setState(() => _isCheckingForUpdates = true);
      // Check if there's an update available.
      final status = await _updater.checkForUpdate(track: _currentTrack);
      if (!mounted) return;
      // If there is an update available, show a banner.
      switch (status) {
        case UpdateStatus.upToDate:
          _showNoUpdateAvailableBanner();
        case UpdateStatus.outdated:
          _showUpdateAvailableBanner();
        case UpdateStatus.restartRequired:
          _showRestartBanner();
        case UpdateStatus.unavailable:
        // Do nothing, there is already a warning displayed at the top of the
        // screen.
      }
    } catch (error) {
      // If an error occurs, we log it for now.
      _log.severe('Error checking for update: $error');
    } finally {
      setState(() => _isCheckingForUpdates = false);
    }
  }

  void _showDownloadingBanner() {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        const MaterialBanner(
          content: Text('Wird heruntergeladen...'),
          actions: [
            SizedBox(height: 14, width: 14, child: CircularProgressIndicator()),
          ],
        ),
      );
  }

  void _showUpdateAvailableBanner() {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: Text('Update verfügbar für  ${_currentTrack.name}.'),
          actions: [
            TextButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                await _downloadUpdate();
                if (!mounted) return;
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('Download'),
            ),
          ],
        ),
      );
  }

  void _showNoUpdateAvailableBanner() {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: Text('Kein Update verfügbar für ${_currentTrack.name}.'),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('Verstanden'),
            ),
          ],
        ),
      );
  }

  void _showRestartBanner() {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: const Text(
            'Ein neuer Patch ist verfügbar! Bitte starte die App neu.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('Verstanden'),
            ),
          ],
        ),
      );
  }

  void _showErrorBanner(Object error) {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: Text('Fehler beim Herunterladen des Updates: $error.'),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('Verstanden'),
            ),
          ],
        ),
      );
  }

  Future<void> _downloadUpdate() async {
    _showDownloadingBanner();
    try {
      // Perform the update (e.g download the latest patch on [_currentTrack]).
      // Note that [track] is optional. Not passing it will default to the
      // stable track.
      await _updater.update(track: _currentTrack);
      if (!mounted) return;
      // Show a banner to inform the user that the update is ready and that they
      // need to restart the app.
      _showRestartBanner();
    } on UpdateException catch (error) {
      // If an error occurs, we show a banner with the error message.
      _showErrorBanner(error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const GenericAppBar(iconData: Icons.update, title: 'OTA Update'),
      body: Column(
        children: [
          if (!_isUpdaterAvailable) const _ShorebirdUnavailable(),
          const Spacer(),
          _CurrentPatchVersion(patch: _currentPatch),
          const SizedBox(height: 12),
          _TrackPicker(
            currentTrack: _currentTrack,
            onChanged: (track) {
              setState(() => _currentTrack = track);
            },
          ),
          const Spacer(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isCheckingForUpdates ? null : _checkForUpdate,
        tooltip: 'Auf Updates prüfen',
        child: _isCheckingForUpdates
            ? const _LoadingIndicator()
            : const Icon(Icons.refresh),
      ),
      bottomNavigationBar: const BottomNavBarNoFilterButton(),
    );
  }
}

/// Widget that is mounted when Shorebird is not available.
class _ShorebirdUnavailable extends StatelessWidget {
  const _ShorebirdUnavailable();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Text(
          '''
OTA Update ist nicht verfügbar.
Bitte stelle sicher, dass die App mit `shorebird release` generiert wurde und dass sie im Release-Modus läuft.''',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.error,
          ),
        ),
      ),
    );
  }
}

/// Widget that displays the current patch version.
class _CurrentPatchVersion extends StatelessWidget {
  const _CurrentPatchVersion({required this.patch});

  final Patch? patch;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Aktuelle Patch-Version:'),
          Text(
            patch != null ? '${patch!.number}' : 'Kein Patch installiert',
            style: theme.textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}

/// Widget that allows selection of update track.
class _TrackPicker extends StatelessWidget {
  const _TrackPicker({required this.currentTrack, required this.onChanged});

  final UpdateTrack currentTrack;

  final ValueChanged<UpdateTrack> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Update track:'),
        SegmentedButton<UpdateTrack>(
          segments: const [
            ButtonSegment(label: Text('Stable'), value: UpdateTrack.stable),
            ButtonSegment(
              label: Text('Beta'),
              icon: Icon(Icons.science),
              value: UpdateTrack.beta,
            ),
            ButtonSegment(
              label: Text('Staging'),
              icon: Icon(Icons.construction),
              value: UpdateTrack.staging,
            ),
          ],
          selected: {currentTrack},
          onSelectionChanged: (tracks) => onChanged(tracks.single),
        ),
      ],
    );
  }
}

/// A reusable loading indicator.
class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 14,
      width: 14,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}
