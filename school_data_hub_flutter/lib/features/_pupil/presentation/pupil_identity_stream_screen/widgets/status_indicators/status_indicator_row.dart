import 'package:flutter/widgets.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_identity_stream_screen/widgets/status_indicators/compact_status_indicator.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_identity_stream_screen/widgets/status_indicators/status_indicators.dart';

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
    super.key,
    required this.role,
    required this.isConnected,
    required this.requestReceived,
    required this.requestSent,
    required this.isTransmitting,
    required this.isProcessing,
    required this.isCompleted,
    required this.transferCounter,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    if (role == PupilIdentityStreamRole.sender) {
      return CardBox(
        padding: const EdgeInsets.all(12.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: style.colors.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Style.radii.medium),
          ),
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
