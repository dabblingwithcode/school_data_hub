import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/support_category_status_batches.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/support_goals_list.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

final _mainMenuBottomNavManager = di<BottomNavManager>();

class LearningSupportCard extends WatchingStatefulWidget {
  final PupilProxy pupil;
  const LearningSupportCard(this.pupil, {super.key});

  @override
  State<LearningSupportCard> createState() => _LearningSupportCardState();
}

class _LearningSupportCardState extends State<LearningSupportCard> {
  final CustomExpansionTileController _tileController =
      CustomExpansionTileController();
  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = watch(widget.pupil);

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin:
          const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AvatarWithBadges(pupil: pupil, size: 80),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(15),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              onTap: () {
                                _mainMenuBottomNavManager
                                    .setPupilProfileNavPage(8);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => PupilProfilePage(
                                    pupil: pupil,
                                  ),
                                ));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    pupil.firstName,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Gap(5),
                                  Text(
                                    pupil.lastName,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Gap(5),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        const Text('ärztl. U.:'),
                        const Gap(10),
                        Text(
                          'placeholder',
                          // TODO: uncomment when ready
                          // LearningSupportHelper.preschoolRevision(
                          //     pupil.preschoolRevision!),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Gap(15),
                    if (pupil.supportCategoryStatuses != null)
                      if (pupil.supportCategoryStatuses!.isNotEmpty)
                        InkWell(
                          onTap: () {
                            _tileController.isExpanded
                                ? _tileController.collapse()
                                : _tileController.expand();
                          },
                          child: SupportCategoryStatusBatches(pupil: pupil),
                        ),
                  ],
                ),
              ),
              const Gap(8),
              InkWell(
                onTap: () {
                  _tileController.isExpanded
                      ? _tileController.collapse()
                      : _tileController.expand();
                },
                onLongPress: () async {
                  // TODO: uncomment when ready
                  //    supportLevelDialog(context, pupil, pupil.latestSupportLevel);
                },
                child: Column(
                  children: [
                    const Gap(20),
                    const Text('Ebene'),
                    Center(
                      child: Text(
                        'XX',
                        // pupil.supportLevel == 4
                        //     ? 'RB'
                        //     : pupil.supportLevel.toString(),
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: AppColors.backgroundColor,
                        ),
                      ),
                    ),
                    Text(
                      pupil.specialNeeds != null
                          ? pupil.specialNeeds!.length == 4
                              ? '${pupil.specialNeeds!.substring(0, 2)} ${pupil.specialNeeds!.substring(2, 4)}'
                              : pupil.specialNeeds!.substring(0, 2)
                          : '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.groupColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(15),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: CustomExpansionTileContent(
                title: null,
                tileController: _tileController,
                widgetList: [
                  SupportGoalsList(
                    pupil: pupil,
                  )
                ]),
          )
        ],
      ),
    );
  }
}
