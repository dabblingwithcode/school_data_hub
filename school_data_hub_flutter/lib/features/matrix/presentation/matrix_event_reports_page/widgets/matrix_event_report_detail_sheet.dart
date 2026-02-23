import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_event_report.dart';

class MatrixEventReportDetailSheet extends StatelessWidget {
  final int reportId;

  const MatrixEventReportDetailSheet({required this.reportId, super.key});

  @override
  Widget build(BuildContext context) {
    final matrixPolicyManager = di<MatrixPolicyManager>();

    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, controller) {
        return Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: FutureBuilder<MatrixEventReportDetail?>(
            future: matrixPolicyManager.fetchEventReportDetail(reportId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final report = snapshot.data;
              if (report == null) {
                return const Center(
                  child: Text('Details konnten nicht geladen werden.'),
                );
              }

              final eventJson = report.eventJson;
              final prettyJson = eventJson == null
                  ? '-'
                  : const JsonEncoder.withIndent('  ').convert(eventJson);

              return ListView(
                controller: controller,
                padding: const EdgeInsets.all(16),
                children: [
                  Center(
                    child: Container(
                      width: 48,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const Gap(16),
                  Text(
                    'Event Report #${report.id}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(12),
                  _DetailLine(
                    label: 'Raum',
                    value: report.name ?? report.roomId,
                  ),
                  _DetailLine(label: 'Room ID', value: report.roomId),
                  _DetailLine(label: 'Event ID', value: report.eventId),
                  _DetailMxIdLine(
                    label: 'Meldender',
                    mxId: report.userId,
                    resolvedName: _resolveMxIdToName(
                      matrixPolicyManager,
                      report.userId,
                    ),
                  ),
                  _DetailMxIdLine(
                    label: 'Gemeldeter Sender',
                    mxId: report.sender,
                    resolvedName: _resolveMxIdToName(
                      matrixPolicyManager,
                      report.sender,
                    ),
                  ),
                  _DetailLine(
                    label: 'Zeit',
                    value: _formatTimestamp(report.receivedTs),
                  ),
                  _DetailLine(label: 'Score', value: '${report.score ?? '-'}'),
                  _DetailLine(
                    label: 'Alias',
                    value: report.canonicalAlias ?? '-',
                  ),
                  _DetailLine(label: 'Grund', value: report.reason ?? '-'),
                  const Gap(16),
                  Card(
                    color: Colors.grey[100],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  _resolveMxIdToName(
                                    matrixPolicyManager,
                                    report.sender,
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Text(
                                _formatTimestamp(report.receivedTs),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const Gap(8),
                          Text(
                            _extractMessageContent(eventJson),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(16),
                  const Text(
                    'event_json',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Gap(8),
                  SelectableText(
                    prettyJson,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                    ),
                  ),
                  const Gap(24),
                ],
              );
            },
          ),
        );
      },
    );
  }

  static String _formatTimestamp(int timestamp) {
    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
    final mm = dt.month.toString().padLeft(2, '0');
    final dd = dt.day.toString().padLeft(2, '0');
    final hh = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$dd.$mm.${dt.year} $hh:$min';
  }

  static String _extractMessageContent(Map<String, dynamic>? eventJson) {
    if (eventJson == null) return '-';

    // Try to get the message body from the event content
    final content = eventJson['content'];
    if (content is Map<String, dynamic>) {
      final body = content['body'];
      if (body is String) return body;
    }

    return '-';
  }

  static String _resolveMxIdToName(
    MatrixPolicyManager matrixPolicyManager,
    String mxId,
  ) {
    final knownUsers = matrixPolicyManager.matrixUsers.value;
    for (final matrixUser in knownUsers) {
      if (matrixUser.id == mxId && matrixUser.displayName.isNotEmpty) {
        return matrixUser.displayName;
      }
    }

    var localPart = mxId;
    if (localPart.startsWith('@')) {
      localPart = localPart.substring(1);
    }
    if (localPart.contains(':')) {
      localPart = localPart.split(':').first;
    }
    return localPart;
  }
}

class _DetailLine extends StatelessWidget {
  final String label;
  final String value;

  const _DetailLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}

class _DetailMxIdLine extends StatelessWidget {
  final String label;
  final String mxId;
  final String resolvedName;

  const _DetailMxIdLine({
    required this.label,
    required this.mxId,
    required this.resolvedName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 4,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          InkWell(
            onTap: () => MatrixPolicyHelper.launchMatrixUrl(context, mxId),
            child: Tooltip(
              message: mxId,
              child: Text(
                resolvedName,
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
