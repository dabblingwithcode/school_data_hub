import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

typedef OnCardPressCallback = void Function(int id);

class SelectPupilListCard extends WatchingWidget {
  final PupilProxy passedPupil;
  final OnCardPressCallback onCardPress;
  final bool isSelectMode;
  final bool isSelected;
  const SelectPupilListCard(
      {required this.passedPupil,
      required this.onCardPress,
      required this.isSelectMode,
      required this.isSelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = passedPupil;

    return GestureDetector(
      onLongPress: () => onCardPress(pupil.pupilId),
      onTap: () => isSelectMode ? onCardPress(pupil.pupilId) : {},
      child: Card(
          color: isSelected ? AppColors.selectedCardColor : Colors.white,
          child: Row(
            children: [
              AvatarWithBadges(pupil: pupil, size: 80),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => PupilProfilePage(
                      pupil: pupil,
                    ),
                  ));
                },
                child: SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                '${pupil.firstName} ${pupil.lastName}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                      // Gap(5),
                      // Row(
                      //   children: [
                      //     Text('bisjetzt verdient:'),
                      //     Gap(10),
                      //     Text(
                      //       pupil.creditEarned.toString(),
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 18,
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
