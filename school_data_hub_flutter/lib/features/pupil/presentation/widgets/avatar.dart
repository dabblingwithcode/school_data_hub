import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/cached_image_or_download_inage.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_helper_functions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_helper.dart';
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
                      child = CircularProgressIndicator(
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
            : Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size / 2),
                  // border: Border.all(
                  //   color: avatarAuth
                  //       ? const Color.fromARGB(255, 29, 221, 35)
                  //       : const Color.fromARGB(255, 255, 228, 20),
                  //   width: 3,
                  // ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size / 2),
                  child: Image.asset(
                    avatarAuth
                        ? 'assets/dummy-profile-pic-auth.png'
                        : 'assets/dummy-profile-pic-unauth.png',
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      ),
    );
  }
}

class AvatarWithBadges extends WatchingWidget {
  static const double _badgeSize = 30.0;
  static const double _badgeOffset = -1.0;
  static const double _avatarPadding = 1.0;

  final PupilProxy pupil;
  final double size;
  const AvatarWithBadges({required this.pupil, required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    final badgeMargin = (_badgeSize / 2) + _badgeOffset;
    final containerSize = size + (badgeMargin * 2);
    final specialNeedsText = pupil.specialNeeds != null
        ? pupil.specialNeeds!.length == 4
              ? '${pupil.specialNeeds!.substring(0, 2)}\n${pupil.specialNeeds!.substring(2, 4)}'
              : pupil.specialNeeds!.substring(0, 2)
        : '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: containerSize,
        height: containerSize,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
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
                  padding: const EdgeInsets.all(_avatarPadding),
                  child: AvatarImage(pupil: pupil, size: size),
                ),
              ),
            ),
            if (pupil.specialNeeds != null)
              Positioned(
                top: 0,
                bottom: 0,
                right: -_badgeOffset,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        specialNeedsText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 4
                            ..color = Colors.white,
                        ),
                      ),

                      const SizedBox(),
                      Text(
                        specialNeedsText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.groupColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (pupil.specialInformation != null)
              Positioned(
                top: 0,
                bottom: 0,
                left: -_badgeOffset,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      informationDialog(
                        context,
                        'Besondere Information',
                        pupil.specialInformation!,
                      );
                    },
                    child: const Icon(
                      Icons.info_rounded,
                      size: 25,
                      color: Color.fromARGB(255, 6, 92, 163),
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: -_badgeOffset,
              left: -_badgeOffset,
              child: Container(
                width: pupil.siblingIds.isNotEmpty
                    ? _badgeSize + 3
                    : _badgeSize,
                height: pupil.siblingIds.isNotEmpty
                    ? _badgeSize + 3
                    : _badgeSize,
                decoration: BoxDecoration(
                  border: pupil.siblingIds.isNotEmpty
                      ? Border.all(
                          color: const Color.fromARGB(255, 120, 127, 216),
                          width: 3,
                        )
                      : null,
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
              bottom: -_badgeOffset,
              right: -_badgeOffset,
              child: Container(
                width: pupil.family != null ? _badgeSize + 3 : _badgeSize,
                height: pupil.family != null ? _badgeSize + 3 : _badgeSize,
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
                top: -_badgeOffset,
                left: -_badgeOffset,
                child: Container(
                  width: _badgeSize,
                  height: _badgeSize,
                  decoration: BoxDecoration(
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
                top: -_badgeOffset,
                right: -_badgeOffset,
                child: Container(
                  width: _badgeSize,
                  height: _badgeSize,
                  decoration: BoxDecoration(
                    color:
                        PupilProxyHelper.hasLanguageSupport(
                          pupil.migrationSupportEnds,
                        )
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
      ),
    );
  }
}
