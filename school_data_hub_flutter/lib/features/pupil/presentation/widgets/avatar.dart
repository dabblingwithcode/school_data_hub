import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/cached_image_or_download_inage.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_helper_functions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_helper_functions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_set_avatar.dart';
import 'package:watch_it/watch_it.dart';
import 'package:widget_zoom/widget_zoom.dart';

class AvatarImage extends WatchingWidget {
  final PupilProxy pupil;
  final double size;
  const AvatarImage({
    required this.pupil,
    required this.size,
    super.key,
    Key? customKey,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = watchPropertyValue((m) => m.avatar, target: pupil);

    // TODO Thomas: How do I watch just pupil.avatarAuth?
    // final avatar =
    //         watchPropertyValue<PupilProxy, HubDocument?>((pupil) => pupil.avatar);

    final bool avatarAuth = (pupil.avatarAuth != null);
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: avatar != null
            ? WidgetZoom(
                heroAnimationTag: avatar.documentId,
                zoomWidget: FutureBuilder<Widget>(
                  future: cachedImageOrDownloadImage(
                    documentId: avatar.documentId,
                    decrypt: true,
                  ),
                  builder: (context, snapshot) {
                    Widget child;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Display a loading indicator while the future is not complete
                      child = const CircularProgressIndicator(
                        strokeWidth: 8,
                        color: AppColors.backgroundColor,
                      );
                    } else if (snapshot.hasError) {
                      // Display an error message if the future encounters an error
                      child = Text('Error: ${snapshot.error}');
                    } else {
                      child = snapshot.data!;
                    }
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(size / 2),
                        child: child,
                      ),
                    );
                  },
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(size / 2),
                child: avatarAuth
                    ? Image.asset(
                        'assets/dummy-profile-pic-auth.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/dummy-profile-pic-unauth.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
      ),
    );
  }
}

class AvatarWithBadges extends WatchingWidget {
  final PupilProxy pupil;
  final double size;
  const AvatarWithBadges({required this.pupil, required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    // watchValue((AttendanceManager x) => x.missedSchooldays);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          GestureDetector(
            onLongPressStart: (details) {
              if (pupil.avatarAuth == null) {
                informationDialog(
                  context,
                  'Einwilligung nicht vorhanden',
                  'Bitte zuerst die Einwilligung einholen und in der App dokumentieren (im Kindprofil unter "Infos"). ',
                );
                return;
              }
              final offset = details.globalPosition;
              final position = RelativeRect.fromLTRB(
                offset.dx,
                offset.dy,
                offset.dx,
                offset.dy,
              );
              showMenu(
                context: context,
                position: position,
                items: [
                  PopupMenuItem(
                    child: pupil.avatar == null
                        ? const Text('Foto hochladen')
                        : const Text('Foto ersetzen'),
                    onTap: () => setAvatar(context: context, pupil: pupil),
                  ),
                  if (pupil.avatar != null)
                    PopupMenuItem(
                      child: const Text('Foto löschen'),
                      onTap: () async {
                        final confirm = await confirmationDialog(
                          context: context,
                          title: 'Foto löschen',
                          message: 'Möchten Sie wirklich das Foto löschen?',
                        );
                        if (confirm != true) return;
                        await PupilMutator().deletePupilDocument(
                          pupil.pupilId,
                          pupil.avatar!.documentId,
                          PupilDocumentType.avatar,
                        );
                      },
                    ),
                ],
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: AvatarImage(pupil: pupil, size: size),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: AttendanceHelper.pupilIsMissedToday(pupil)
                    ? AppColors.warningButtonColor
                    : AppColors.groupColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  pupil.group,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: pupil.schoolyearHeldBackAt != null ? 33.0 : 30.0,
              height: pupil.schoolyearHeldBackAt != null ? 33.0 : 30.0,
              decoration: BoxDecoration(
                border: pupil.schoolyearHeldBackAt != null
                    ? Border.all(
                        color: const Color.fromARGB(255, 250, 197, 98),
                        width: 3,
                      )
                    : null,
                color: SchoolDayEventHelper.pupilIsAdmonishedToday(pupil)
                    ? Colors.red
                    : AppColors.schoolyearColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  pupil.schoolGrade.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          if (pupil.afterSchoolCare != null)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: const BoxDecoration(
                  color: AppColors.ogsColor,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'OGS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          if (pupil.migrationSupportEnds != null)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color:
                      PupilHelper.hasLanguageSupport(pupil.migrationSupportEnds)
                      ? Colors.green
                      : Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.language_rounded, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
