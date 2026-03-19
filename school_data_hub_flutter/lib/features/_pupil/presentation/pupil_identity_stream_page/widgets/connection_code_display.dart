import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class ConnectionCodeDisplay extends StatelessWidget {
  final String channelName;
  final String? description;

  const ConnectionCodeDisplay({
    super.key,
    required this.channelName,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return CardBox(
      padding: const EdgeInsets.all(16.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: style.colors.accent,
          borderRadius: BorderRadius.circular(Style.radii.medium),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Verbindungscode',
                style: context.typography.title.withColor(style.colors.background),
              ),
              const Gap(8),
              if (channelName.isNotEmpty)
                RepaintBoundary(
                  child: QrImageView(
                    size: 200,
                    padding: const EdgeInsets.all(20),
                    backgroundColor: style.colors.background,
                    data: channelName,
                    version: QrVersions.auto,
                  ),
                ),
              Text(
                channelName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: style.colors.background,
                  letterSpacing: 2.0,
                ),
              ),
              const Gap(16),
              Text(
                description ?? 'Teile diesen Code mit dem Empfänger',
                style: context.typography.body.withColor(
                  style.colors.background.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
