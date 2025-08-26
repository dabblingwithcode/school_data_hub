import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/core/updater/shorebird_update_manager.dart';
import 'package:school_data_hub_flutter/core/updater/update_status_widget.dart';
import 'package:watch_it/watch_it.dart';

/// Example of how to use the ShorebirdUpdateManager
class UpdateManagerExample extends StatefulWidget {
  const UpdateManagerExample({super.key});

  @override
  State<UpdateManagerExample> createState() => _UpdateManagerExampleState();
}

class _UpdateManagerExampleState extends State<UpdateManagerExample> {
  late final ShorebirdUpdateManager _updateManager;

  @override
  void initState() {
    super.initState();
    _updateManager = di<ShorebirdUpdateManager>();
    
    // Optional: Check for updates when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateManager.checkForUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Manager'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Update Status',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            
            // The update status widget handles all the UI
            UpdateStatusWidget(),
            
            SizedBox(height: 24),
            
            Text(
              'Auto-update Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            
            _AutoUpdateSettings(),
          ],
        ),
      ),
    );
  }
}

/// Widget for managing auto-update settings
class _AutoUpdateSettings extends WatchingWidget {
  const _AutoUpdateSettings();

  @override
  Widget build(BuildContext context) {
    final updateManager = di<ShorebirdUpdateManager>();
    final autoCheckEnabled = watchPropertyValue(
      (ShorebirdUpdateManager x) => x.autoCheckEnabled,
    );
    final autoCheckInterval = watchPropertyValue(
      (ShorebirdUpdateManager x) => x.autoCheckInterval,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Auto-check for updates'),
              subtitle: const Text('Automatically check for updates in the background'),
              value: autoCheckEnabled,
              onChanged: (value) {
                updateManager.setAutoCheckEnabled(value);
              },
            ),
            
            if (autoCheckEnabled) ...[
              const Divider(),
              ListTile(
                title: const Text('Check interval'),
                subtitle: Text('Every ${autoCheckInterval.inHours} hours'),
                trailing: DropdownButton<Duration>(
                  value: autoCheckInterval,
                  onChanged: (duration) {
                    if (duration != null) {
                      updateManager.setAutoCheckInterval(duration);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: Duration(hours: 1),
                      child: Text('1 hour'),
                    ),
                    DropdownMenuItem(
                      value: Duration(hours: 3),
                      child: Text('3 hours'),
                    ),
                    DropdownMenuItem(
                      value: Duration(hours: 6),
                      child: Text('6 hours'),
                    ),
                    DropdownMenuItem(
                      value: Duration(hours: 12),
                      child: Text('12 hours'),
                    ),
                    DropdownMenuItem(
                      value: Duration(hours: 24),
                      child: Text('24 hours'),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
