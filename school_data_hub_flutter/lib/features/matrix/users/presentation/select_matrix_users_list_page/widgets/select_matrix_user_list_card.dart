import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/matrix_user_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/select_matrix_users_list_page/controller/select_matrix_users_list_controller.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

class SelectMatrixUserCard extends WatchingWidget {
  final SelectMatrixUsersListController controller;
  final MatrixUser passedUser;

  const SelectMatrixUserCard(this.controller, this.passedUser, {super.key});
  @override
  Widget build(BuildContext context) {
    PupilProxy? pupil;

    final matrixUser = watch<MatrixUser>(passedUser);
    final MatrixUserRelationship? userRelationship =
        MatrixUserHelper.getUserRelationship(matrixUser);

    return GestureDetector(
      onLongPress: () => controller.onCardPress(matrixUser.id!),
      onTap: () =>
          controller.isSelectMode ? controller.onCardPress(matrixUser.id!) : {},
      child: Card(
          color: controller.selectedUsers.contains(matrixUser.id!)
              ? AppColors.selectedCardColor
              : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 1.0,
          margin: const EdgeInsets.only(
              left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
          child: Row(
            children: [
              const Gap(10),
              if (userRelationship?.isParent == true)
                ...userRelationship!.familyPupils!.map((pupil) => InkWell(
                    onTap: () {
                      di<BottomNavManager>().setPupilProfileNavPage(
                          ProfileNavigationState.info.value);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => PupilProfilePage(
                          pupil: pupil,
                        ),
                      ));
                    },
                    child: AvatarWithBadges(pupil: pupil, size: 70))),
              (userRelationship?.pupil != null)
                  ? InkWell(
                      onTap: () {
                        di<BottomNavManager>().setPupilProfileNavPage(
                            ProfileNavigationState.info.value);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => PupilProfilePage(
                            pupil: userRelationship.pupil!,
                          ),
                        ));
                      },
                      child: AvatarWithBadges(
                          pupil: userRelationship!.pupil!, size: 70))
                  : (userRelationship?.isTeacher == true)
                      ? const SizedBox(
                          width: 90,
                          height: 90,
                          child: Padding(
                            padding: EdgeInsets.only(left: 5, right: 14),
                            child: Icon(Icons.school_rounded, size: 60),
                          ),
                        )
                      : const SizedBox(
                          width: 90,
                          height: 90,
                          child: Padding(
                            padding: EdgeInsets.only(left: 5, right: 14),
                            child: Icon(
                              Icons.question_mark_rounded,
                              size: 70,
                              color: Colors.red,
                            ),
                          ),
                        ),
              InkWell(
                onTap: () {
                  if (pupil != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => PupilProfilePage(
                        pupil: pupil,
                      ),
                    ));
                  }
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
                                matrixUser.displayName,
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
