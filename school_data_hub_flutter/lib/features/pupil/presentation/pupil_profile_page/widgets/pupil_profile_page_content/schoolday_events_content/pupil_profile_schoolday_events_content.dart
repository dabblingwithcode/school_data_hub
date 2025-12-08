import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/schoolday_event_list_page.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/pupil_schoolday_events_list.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_content_widgets.dart';

class PupilProfileSchooldayEventsContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilProfileSchooldayEventsContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.pupilProfileBackgroundColor),
      child: Column(
        children: [
          PupilProfileContentSection(
            icon: Icons.warning_amber_rounded,
            title: 'Ereignisse',
            onTitleTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const SchooldayEventListPage(),
                ),
              );
            },
            child: PupilSchooldayEventsList(pupil: pupil),
          ),
        ],
      ),
    );
  }
}
