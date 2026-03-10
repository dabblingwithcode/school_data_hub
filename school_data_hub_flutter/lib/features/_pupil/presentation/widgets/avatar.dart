import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/get_cached_image_or_download_inage.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/pupil_set_avatar.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:widget_zoom/widget_zoom.dart';

class AvatarImage extends WatchingWidget {
  final PupilProxy pupil;
  final double size;
  final String? heroTag;
  const AvatarImage({
    required this.pupil,
    required this.size,
    this.heroTag,
    super.key,
    Key? customKey,
  });

  @override
  Widget build(BuildContext context) {
    watchPropertyValue((m) => m.avatarId, target: pupil);
    final avatar = pupil.avatar;

    final bool avatarAuth = (pupil.avatarAuth != null);
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: avatar != null
            ? WidgetZoom(
                heroAnimationTag:
                    heroTag ?? '${avatar.documentId}_${pupil.pupilId}',
                zoomWidget: FutureBuilder<Widget>(
                  future: getCachedImageOrDownloadImage(
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

/// Container-only badge that shows school grade and admonition state.
/// Rebuilds when the pupil's schoolday events change.
class _SchoolGradeBadgeContainer extends WatchingWidget {
  final PupilProxy pupil;
  final double badgeSize;

  const _SchoolGradeBadgeContainer({
    required this.pupil,
    required this.badgeSize,
  });

  @override
  Widget build(BuildContext context) {
    final schooldayEventManager = di<SchooldayEventManager>();
    watch(schooldayEventManager.getPupilSchooldayEventsProxy(pupil.pupilId));

    final size = pupil.family != null ? badgeSize + 3 : badgeSize;
    return Container(
      width: size,
      height: size,
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
    );
  }
}

/// Container-only badge that shows group and missed-today state.
/// Rebuilds when the pupil's missed schooldays change (pupilIsMissedToday).
class _GroupBadgeContainer extends WatchingWidget {
  final PupilProxy pupil;
  final double badgeSize;

  const _GroupBadgeContainer({required this.pupil, required this.badgeSize});

  @override
  Widget build(BuildContext context) {
    final attendanceManager = di<AttendanceManager>();
    watch(attendanceManager.getPupilMissedSchooldaysProxy(pupil.pupilId));

    final size = pupil.siblingIds.isNotEmpty ? badgeSize + 3 : badgeSize;
    return Container(
      width: size,
      height: size,
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
    );
  }
}

class AvatarWithBadges extends StatelessWidget {
  static const double _badgeSize = 30.0;
  static const double _badgeOffset = -1.0;
  static const double _avatarPadding = 1.0;

  final PupilProxy pupil;
  final double size;
  final String? heroTag;
  const AvatarWithBadges({
    required this.pupil,
    required this.size,
    this.heroTag,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final badgeMargin = (_badgeSize / 2) + _badgeOffset;
    final containerSize = size + (badgeMargin * 2);

    final specialNeedsText = pupil.specialNeeds != null
        ? pupil.specialNeeds!.contains('*')
              ? '${pupil.specialNeeds!.split('*').first.replaceAll('ESE', 'ES')}\n${pupil.specialNeeds!.split('*').last.replaceAll('ESE', 'ES')}'
              : pupil.specialNeeds!.replaceAll('ESE', 'ES')
        : null;

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
                      PopupMenuItem<void>(
                        child: pupil.avatar == null
                            ? const Text('Foto hochladen')
                            : const Text('Foto ersetzen'),
                        onTap: () => setAvatar(context: context, pupil: pupil),
                      ),
                      if (pupil.avatar != null)
                        PopupMenuItem<void>(
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
                  child: AvatarImage(
                    pupil: pupil,
                    size: size,
                    heroTag: heroTag,
                  ),
                ),
              ),
            ),
            if (pupil.isBirthdayToday)
              Positioned(
                bottom: -_badgeOffset,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: _badgeSize,
                    height: _badgeSize,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 228, 76, 99),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.cake_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            if (pupil.specialNeeds != null || pupil.latestSupportLevel != null)
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
                        specialNeedsText ??
                            (pupil.latestSupportLevel != null
                                ? pupil.latestSupportLevel!.level.toString()
                                : ''),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: specialNeedsText != null ? 17 : 18,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 4
                            ..color = Colors.white,
                        ),
                      ),

                      const SizedBox(),
                      Text(
                        specialNeedsText ??
                            (pupil.latestSupportLevel != null
                                ? 'FE\n${pupil.latestSupportLevel!.level.toString()}'
                                : ''),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: specialNeedsText != null ? 17 : 18,
                          height: 1.1,
                          color: specialNeedsText != null
                              ? AppColors.groupColor
                              : AppColors.accentColor,
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
                      _specialInformationDialog(
                        context,
                        'Besondere Information',
                        pupil.specialInformation!,
                      );
                    },
                    child: Container(
                      width: _badgeSize - 3,
                      height: _badgeSize - 3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: const Icon(
                        Icons.info_rounded,
                        size: 25,
                        color: Color.fromARGB(255, 6, 92, 163),
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: -_badgeOffset,
              left: -_badgeOffset,
              child: InkWell(
                onTap: () {
                  if (pupil.siblings.isNotEmpty) {
                    _siblingsDialog(context, pupil.siblings);
                  }
                },
                child: _GroupBadgeContainer(
                  pupil: pupil,
                  badgeSize: _badgeSize,
                ),
              ),
            ),
            Positioned(
              bottom: -_badgeOffset,
              right: -_badgeOffset,
              child: _SchoolGradeBadgeContainer(
                pupil: pupil,
                badgeSize: _badgeSize,
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

void _siblingsDialog(BuildContext context, List<PupilProxy> siblings) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      constraints: const BoxConstraints(maxWidth: 400),
      icon: Icon(
        Icons.family_restroom,
        color: AppColors.backgroundColor,
        size: 50,
      ),
      title: const Text(
        'Geschwister',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 400),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: siblings.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final sibling = siblings[index];
              return ListTile(
                leading: AvatarImage(pupil: sibling, size: 40),
                title: Text(
                  '${sibling.firstName} ${sibling.lastName}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Klasse ${sibling.group}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => PupilProfilePage(pupil: sibling),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            style: AppStyles.successButtonStyle,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK", style: AppStyles.buttonTextStyle),
          ),
        ),
      ],
    ),
  );
}

void _specialInformationDialog(
  BuildContext context,
  String title,
  String text,
) {
  final parts = text.split('|');
  final info = parts.isNotEmpty ? parts[0] : text;
  final createdBy = parts.length > 1 ? parts[1] : null;
  final createdAt = parts.length > 2 ? parts[2] : null;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: Icon(Icons.info, color: AppColors.backgroundColor, size: 50),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(info, textAlign: TextAlign.center),
              if (createdBy != null && createdAt != null) ...[
                const SizedBox(height: 15),
                Text(
                  'Erstellt von $createdBy am $createdAt',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.withValues(alpha: 0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            style: AppStyles.successButtonStyle,
            onPressed: () {
              Navigator.of(context).pop(true);
            }, // Add onPressed
            child: const Text("OK", style: AppStyles.buttonTextStyle),
          ),
        ),
      ],
    ),
  );
}
