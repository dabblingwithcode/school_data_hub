import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class SchooldayEventTypeIcon extends StatelessWidget {
  static const String _assetBase = 'assets/images/school_event_icons';
  static const double _iconSize = 28;

  final SchooldayEventType type;
  final double? iconSize;
  const SchooldayEventTypeIcon({required this.type, this.iconSize, super.key});

  static String _assetPathFor(SchooldayEventType type) {
    switch (type) {
      case SchooldayEventType.notSet:
        return '$_assetBase/not_set.png';
      case SchooldayEventType.parentsMeeting:
        return '$_assetBase/parents_meeting.png';
      case SchooldayEventType.admonition:
        return '$_assetBase/red_card.png';
      case SchooldayEventType.afternoonCareAdmonition:
        return '$_assetBase/red_card_afternoon_care.png';
      case SchooldayEventType.admonitionAndBanned:
        return '$_assetBase/red_card_home.png';
      case SchooldayEventType.otherEvent:
        return '$_assetBase/note.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = iconSize ?? _iconSize;
    return Image.asset(
      _assetPathFor(type),
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
