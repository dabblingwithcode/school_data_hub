import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_content_widgets.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/schoolday_event_list_page.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/pupil_schoolday_events_list.dart';

class PupilProfileSchooldayEventsContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilProfileSchooldayEventsContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return PupilProfileContentCard(
      icon: Icons.warning_amber_rounded,
      iconColor: const Color.fromARGB(255, 224, 177, 23),
      title: 'Ereignisse',
      onTitleTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (ctx) => const SchooldayEventListPage(),
          ),
        );
      },
      child: PupilSchooldayEventsList(pupil: pupil),
    );
  }
}
