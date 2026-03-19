import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

enum ReceiverStatus { requested, confirmed, transferring, completed, rejected }

class ReceiverCard extends StatelessWidget {
  final String receiverName;
  final ReceiverStatus status;
  final VoidCallback? onConfirm;
  final VoidCallback? onReject;
  final bool isAnyTransferInProgress;

  const ReceiverCard({
    super.key,
    required this.receiverName,
    required this.status,
    this.onConfirm,
    this.onReject,
    required this.isAnyTransferInProgress,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return CardBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  receiverName,
                  style: context.typography.subtitle.bold,
                ),
              ),
              _buildStatusIcon(style),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _buildStatusText(),
            style: context.typography.body,
          ),
          if (status == ReceiverStatus.requested) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button.small(
                  onPressed: isAnyTransferInProgress ? null : onConfirm,
                  label: 'Bestätigen',
                  variant: ButtonVariant.primary,
                  icon: Icon(Icons.check, color: style.colors.background),
                ),
                Button.small(
                  onPressed: isAnyTransferInProgress ? null : onReject,
                  label: 'Ablehnen',
                  variant: ButtonVariant.destructive,
                  icon: Icon(Icons.close, color: style.colors.background),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusIcon(Style style) {
    switch (status) {
      case ReceiverStatus.requested:
        return Icon(Icons.help_outline, color: style.colors.warning);
      case ReceiverStatus.confirmed:
        return Icon(Icons.check_circle, color: style.colors.success);
      case ReceiverStatus.transferring:
        return const CircularProgressIndicator();
      case ReceiverStatus.completed:
        return Icon(Icons.done_all, color: style.colors.info);
      case ReceiverStatus.rejected:
        return Icon(Icons.block, color: style.colors.error);
    }
  }

  String _buildStatusText() {
    switch (status) {
      case ReceiverStatus.requested:
        return 'Wartet auf Bestätigung';
      case ReceiverStatus.confirmed:
        return 'Bestätigt - Übertragung vorbereitet';
      case ReceiverStatus.transferring:
        return 'Übertragung läuft...';
      case ReceiverStatus.completed:
        return 'Übertragung abgeschlossen';
      case ReceiverStatus.rejected:
        return 'Abgelehnt';
    }
  }
}
