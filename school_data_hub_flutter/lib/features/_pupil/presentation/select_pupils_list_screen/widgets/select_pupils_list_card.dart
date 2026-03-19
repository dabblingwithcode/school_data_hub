import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:flutter_it/flutter_it.dart';

typedef OnCardPressCallback = void Function(int id);

class SelectPupilListCard extends WatchingWidget {
  final PupilProxy passedPupil;
  final OnCardPressCallback onCardPress;
  final bool isSelectMode;
  final bool isSelected;
  const SelectPupilListCard({
    required this.passedPupil,
    required this.onCardPress,
    required this.isSelectMode,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = passedPupil;

    return GestureDetector(
      onLongPress: () => onCardPress(pupil.pupilId),
      onTap: () => isSelectMode ? onCardPress(pupil.pupilId) : {},
      child: CardBox(
        variant: isSelected
            ? CardBoxVariant.filledSecondary
            : CardBoxVariant.filled,
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            AvatarWithBadges(pupil: pupil, size: 80),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (ctx) => PupilProfilePage(pupil: pupil),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${pupil.firstName} ${pupil.lastName}',
                        style: context.typography.subtitle.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
