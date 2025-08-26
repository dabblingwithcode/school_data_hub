import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_identity_stream_page/widgets/status_indicators/compact_status_indicator.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_identity_stream_page/widgets/status_indicators/status_indicators.dart';

class StatusIndicatorRow extends StatelessWidget {
  final PupilIdentityStreamRole role;
  final bool isConnected;
  final bool requestReceived;
  final bool requestSent;
  final bool isTransmitting;
  final bool isProcessing;
  final bool isCompleted;
  final int transferCounter;

  const StatusIndicatorRow({
    Key? key,
    required this.role,
    required this.isConnected,
    required this.requestReceived,
    required this.requestSent,
    required this.isTransmitting,
    required this.isProcessing,
    required this.isCompleted,
    required this.transferCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (role == PupilIdentityStreamRole.sender) {
      return Card(
        color: AppColors.backgroundColor.withValues(alpha: 0.1),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CompactStatusIndicator(
                label: 'Verbindung',
                isActive: isConnected,
              ),
              CompactStatusIndicator(
                label: 'Anfrage',
                isActive: requestReceived,
              ),
              CompactStatusIndicator(
                label:
                    'Transfer${transferCounter > 0 ? ' ($transferCounter)' : ''}',
                isActive: isTransmitting,
              ),
              CompactStatusIndicator(label: 'Fertig', isActive: isCompleted),
            ],
          ),
        ),
      );
    } else {
      return Column(
        children: [
          StatusIndicators(label: 'Verbindung', isActive: isConnected),
          StatusIndicators(label: 'Anfrage gesendet', isActive: requestSent),
          StatusIndicators(
            label: 'Datenübertragung',
            isActive: isTransmitting || (isProcessing && isConnected),
          ),
          StatusIndicators(label: 'Abgeschlossen', isActive: isCompleted),
        ],
      );
    }
  }
}
