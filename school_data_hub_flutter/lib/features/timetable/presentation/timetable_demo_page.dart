import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_page/timetable_page.dart';

/// Demo page to show how to integrate the timetable feature
class TimetableDemoPage extends StatelessWidget {
  const TimetableDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stundenplan Demo'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_today,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 24),
              const Text(
                'Stundenplan Feature',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Verwalten Sie Ihren Stundenplan mit folgenden Features:',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('✓ Wochenansicht mit horizontalem/vertikalem Scrollen'),
                      SizedBox(height: 8),
                      Text('✓ Wechsel zwischen Wochentagen'),
                      SizedBox(height: 8),
                      Text('✓ Filterung nach Klassen'),
                      SizedBox(height: 8),
                      Text('✓ Farbcodierte Fächer'),
                      SizedBox(height: 8),
                      Text('✓ Hinzufügen/Bearbeiten/Löschen von Stunden'),
                      SizedBox(height: 8),
                      Text('✓ Zeitslots von 7:50 bis 13:30'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TimetablePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text(
                  'Stundenplan öffnen',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
