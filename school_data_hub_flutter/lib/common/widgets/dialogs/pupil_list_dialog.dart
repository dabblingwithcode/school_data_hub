import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/pupil_language_card.dart';

class PupilListDialog extends StatefulWidget {
  final String title;
  final List<PupilProxy> pupils;

  const PupilListDialog({super.key, required this.title, required this.pupils});

  @override
  State<PupilListDialog> createState() => _PupilListDialogState();
}

class _PupilListDialogState extends State<PupilListDialog> {
  late final ValueNotifier<List<PupilProxy>> _pupilsListenable;

  @override
  void initState() {
    super.initState();
    _pupilsListenable = ValueNotifier<List<PupilProxy>>(widget.pupils);
  }

  @override
  void didUpdateWidget(covariant PupilListDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pupils != widget.pupils) {
      _pupilsListenable.value = widget.pupils;
    }
  }

  @override
  void dispose() {
    _pupilsListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.canvasColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
        child: Column(
          children: [
            GenericAppBar(title: widget.title, iconData: Icons.people),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  GenericSliverListWithEmptyListCheck(
                    itemsListenable: _pupilsListenable,
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
