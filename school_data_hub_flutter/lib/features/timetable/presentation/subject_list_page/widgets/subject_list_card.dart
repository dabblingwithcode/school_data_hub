import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class SubjectListCard extends StatelessWidget {
  final Subject subject;
  final VoidCallback onTap;

  const SubjectListCard({
    super.key,
    required this.subject,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Color indicator
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: _parseColor(subject.color ?? '#FF5722'),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 16),
              // Subject details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (subject.description != null &&
                        subject.description!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        subject.description!,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${subject.publicId}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow icon
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Color _parseColor(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceAll('#', '0xFF')));
    } catch (e) {
      return Colors.grey;
    }
  }
}
