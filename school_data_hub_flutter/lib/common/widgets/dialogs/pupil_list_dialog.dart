import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_language_card.dart';

class PupilListDialog extends StatelessWidget {
  final String title;
  final List<PupilProxy> pupils;

  const PupilListDialog({super.key, required this.title, required this.pupils});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.canvasColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
        child: Column(
          children: [
            GenericAppBar(title: title, iconData: Icons.people),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  GenericSliverListWithEmptyListCheck(
                    items: pupils,
                    itemBuilder: (context, pupil) =>
                        PupilLanguageCard(passedPupil: pupil),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
