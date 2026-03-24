import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/generic_async_action_button.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/presentation/widgets/dialogues/logout_devices_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/matrix_room_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/matrix_user_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user_relationship.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_screen/widgets/pupil_rooms_list.dart';

class MatrixUsersListCard extends WatchingStatefulWidget {
  final MatrixUser matrixUser;
  final UserWithDevices? appUser;

  const MatrixUsersListCard(this.matrixUser, {super.key, this.appUser});

  @override
  State<MatrixUsersListCard> createState() => _MatrixUsersListCardState();
}

class _MatrixUsersListCardState extends State<MatrixUsersListCard> {
  PupilProxy? pupil;
  late Future<String?> _avatarUrlFuture;

  MatrixPolicyManager get _matrixPolicyManager => di<MatrixPolicyManager>();

  @override
  void initState() {
    super.initState();
    _avatarUrlFuture = _fetchAvatarUrl();
  }

  @override
  void didUpdateWidget(covariant MatrixUsersListCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.matrixUser.id != widget.matrixUser.id) {
      _avatarUrlFuture = _fetchAvatarUrl();
    }
  }

  Future<String?> _fetchAvatarUrl() async {
    final userId = widget.matrixUser.id;
    if (userId == null || userId.isEmpty) {
      return null;
    }
    return _matrixPolicyManager.users.fetchUserAvatarUrl(userId);
  }

  List<String> _toMediaThumbnailUrls({
    required String? avatarUrl,
    required String matrixBaseUrl,
  }) {
    if (avatarUrl == null || avatarUrl.isEmpty) {
      return const [];
    }

    if (!avatarUrl.startsWith('mxc://')) {
      return [avatarUrl];
    }

    final uri = Uri.tryParse(avatarUrl);
    if (uri == null || uri.host.isEmpty || uri.pathSegments.isEmpty) {
      return const [];
    }

    final server = Uri.encodeComponent(uri.host);
    final mediaId = Uri.encodeComponent(uri.pathSegments.join('/'));

    return [
      '$matrixBaseUrl/_matrix/client/v1/media/thumbnail/$server/$mediaId?width=96&height=96&method=crop',
      '$matrixBaseUrl/_matrix/media/v3/thumbnail/$server/$mediaId?width=96&height=96&method=crop',
      '$matrixBaseUrl/_matrix/media/r0/thumbnail/$server/$mediaId?width=96&height=96&method=crop',
    ];
  }

  static const String _matrixIconsBase = 'assets/images/matrix_icons';

  static String _matrixIconPathFor(MatrixUserRelationship? rel) {
    if (rel == null) return '$_matrixIconsBase/teacher.png';
    if (rel.isTeacher) return '$_matrixIconsBase/teacher.png';
    if (rel.isFamily) return '$_matrixIconsBase/family.png';
    if (rel.isParent) return '$_matrixIconsBase/parents.png';
    if (rel.isLinked) return '$_matrixIconsBase/pupil.png';
    return '$_matrixIconsBase/teacher.png';
  }

  Widget _buildAvatar(MatrixUser matrixUser) {
    //  final linkedPupil = MatrixUserHelper.linkedPupil(matrixUser);

    final imageHeaders = {'Authorization': _matrixPolicyManager.matrixToken};

    return Column(
      children: [
        const Gap(10),
        FutureBuilder<String?>(
          future: _avatarUrlFuture,
          builder: (context, snapshot) {
            final avatarUrls = _toMediaThumbnailUrls(
              avatarUrl: snapshot.data,
              matrixBaseUrl: _matrixPolicyManager.matrixUrl,
            );
            final primaryAvatarUrl = avatarUrls.isNotEmpty
                ? avatarUrls.first
                : null;
            final fallbackAvatarUrl = avatarUrls.length > 1
                ? avatarUrls[1]
                : null;

            Future<void> openAvatarPreview() async {
              if (primaryAvatarUrl == null) {
                return;
              }

              await showDialog<void>(
                context: context,
                builder: (_) {
                  return Dialog(
                    child: SizedBox(
                      width: 360,
                      height: 360,
                      child: InteractiveViewer(
                        child: Image.network(
                          primaryAvatarUrl,
                          headers: imageHeaders,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) =>
                              fallbackAvatarUrl != null
                              ? Image.network(
                                  fallbackAvatarUrl,
                                  headers: imageHeaders,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) => const Center(
                                    child: Icon(Icons.person, size: 64),
                                  ),
                                )
                              : const Center(
                                  child: Icon(Icons.person, size: 64),
                                ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return Tooltip(
              message: 'Avatar öffnen',
              child: InkWell(
                onTap: openAvatarPreview,
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: ClipOval(
                    child: primaryAvatarUrl != null
                        ? Image.network(
                            primaryAvatarUrl,
                            headers: imageHeaders,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                fallbackAvatarUrl != null
                                ? Image.network(
                                    fallbackAvatarUrl,
                                    headers: imageHeaders,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: Colors.grey.shade300,
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.person, size: 28),
                                    ),
                                  )
                                : Container(
                                    color: Colors.grey.shade300,
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.person, size: 28),
                                  ),
                          )
                        : Container(
                            color: Colors.grey.shade300,
                            alignment: Alignment.center,
                            child: const Icon(Icons.person, size: 28),
                          ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _showMessageDialog(
    BuildContext context,
    MatrixUser matrixUser,
  ) async {
    final TextEditingController messageController = TextEditingController();
    bool isSending = false;

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(Icons.message, color: Colors.blue),
                  const Gap(10),
                  Expanded(
                    child: Text(
                      'Nachricht senden an ${matrixUser.displayName}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Matrix ID: ${matrixUser.id}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Nachricht eingeben...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    enabled: !isSending,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isSending
                      ? null
                      : () => Navigator.of(context).pop(),
                  child: const Text('Abbrechen'),
                ),
                ElevatedButton(
                  onPressed: isSending
                      ? null
                      : () async {
                          if (messageController.text.trim().isEmpty) return;

                          setState(() => isSending = true);

                          try {
                            log('Sending direct message to ${matrixUser.id}');
                            log(
                              'Message text: ${messageController.text.trim()}',
                            );

                            final result = await _matrixPolicyManager
                                .sendDirectTextMessage(
                                  targetUserId: matrixUser.id!,
                                  text: messageController.text.trim(),
                                );

                            log('Message sent successfully: $result');

                            if (context.mounted) {
                              Navigator.of(context).pop();
                              di<NotificationManager>().showSnackBar(
                                NotificationType.success,
                                'Nachricht an ${matrixUser.displayName} gesendet!',
                              );
                            }
                          } catch (e, stackTrace) {
                            log('Error sending message: $e');
                            log('Stack trace: $stackTrace');

                            if (context.mounted) {
                              di<NotificationManager>().showSnackBar(
                                NotificationType.error,
                                'Fehler beim Senden: $e',
                              );
                            }
                          } finally {
                            if (context.mounted) {
                              setState(() => isSending = false);
                            }
                          }
                        },
                  child: isSending
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Senden'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final tileController = createOnce(() => ExpansionController());
    final matrixUser = watch<MatrixUser>(widget.matrixUser);

    final MatrixUserRelationship? userRelationship =
        MatrixUserHelper.getUserRelationship(matrixUser);

    // final borderColor =
    //     !MatrixUserHelper.isLinkedToPupil(matrixUser) &&
    //         matrixUser.id!.contains('_')
    //     ? const Color.fromARGB(255, 255, 179, 64)
    //     : userRelationship != null && userRelationship.isParent
    //     ? Colors.grey
    //     : !matrixUser.id!.contains('_')
    //     ? const Color.fromARGB(255, 62, 37, 186)
    //     : Colors.white;

    return Card(
      color: style.colors.background,
      surfaceTintColor: style.colors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        // side: BorderSide(color: borderColor, width: 2),
      ),
      elevation: 1.0,
      margin: const EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        top: 4.0,
        bottom: 4.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(10),
              _buildAvatar(matrixUser),
              // if (userRelationship?.familyPupils != null)
              //   ...userRelationship!.familyPupils!.map(
              //     (pupil) => InkWell(
              //       onTap: () {
              //         _mainMenuBottomNavManager.setPupilProfileNavPage(
              //           ProfileNavigationState.info.value,
              //         );
              //         Navigator.of(context, rootNavigator: true).push(
              //           MaterialPageRoute(
              //             builder: (ctx) => PupilProfilePage(pupil: pupil),
              //           ),
              //         );
              //       },
              //       child: AvatarWithBadges(pupil: pupil, size: 70),
              //     ),
              //   ),
              // (userRelationship?.pupil != null)
              //     ? InkWell(
              //         onTap: () {
              //           _mainMenuBottomNavManager.setPupilProfileNavPage(
              //             ProfileNavigationState.info.value,
              //           );
              //           Navigator.of(context, rootNavigator: true).push(
              //             MaterialPageRoute(
              //               builder: (ctx) => PupilProfilePage(
              //                 pupil: userRelationship.pupil!,
              //               ),
              //             ),
              //           );
              //         },
              //         child: AvatarWithBadges(
              //           pupil: userRelationship!.pupil!,
              //           size: 70,
              //         ),
              //       )
              //     : (userRelationship?.isTeacher == true)
              //     ? const SizedBox(
              //         width: 90,
              //         height: 70,
              //         child: Padding(
              //           padding: EdgeInsets.only(left: 5, top: 15, right: 14),
              //           child: Icon(Icons.school_rounded, size: 60),
              //         ),
              //       )
              //     : (userRelationship?.familyPupils != null)
              //     ? const SizedBox.shrink()
              //     : const SizedBox(
              //         width: 90,
              //         height: 70,
              //         child: Padding(
              //           padding: EdgeInsets.only(left: 5, top: 15, right: 14),
              //           child: Icon(
              //             Icons.question_mark_rounded,
              //             size: 70,
              //             color: Colors.red,
              //           ),
              //         ),
              //       ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              onLongPress: () async {
                                final String? changedName =
                                    await shortTextfieldDialog(
                                      context: context,
                                      title: 'Name ändern',
                                      labelText: 'Name ändern',
                                      textinField: matrixUser.displayName,
                                      hintText: 'Neuer Name',
                                      obscureText: false,
                                    );
                                if (changedName != null) {
                                  matrixUser.displayName = changedName;
                                  _matrixPolicyManager.pendingChangesHandler(
                                    true,
                                  );
                                }
                              },
                              onTap: () {
                                final pupil = MatrixUserHelper.linkedPupil(
                                  matrixUser,
                                );
                                if (pupil == null) {
                                  di<NotificationManager>().showInformationDialog(
                                    NotificationType.error,
                                    'Dieser Benutzer ist keinem Schüler zugeordnet.',
                                  );
                                  return;
                                }
                                context.push(
                                  RoutePaths.pupilProfilePath(
                                    pupil.internalId,
                                  ),
                                  extra: pupil,
                                );
                              },
                              child: matrixUser.isParent
                                  ? Text(
                                      '${matrixUser.displayName} 👨‍👩‍👦',
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      textAlign: TextAlign.left,
                                      style: context.typography.subtitle.bold
                                          .withColor(style.colors.foreground),
                                    )
                                  : Text(
                                      matrixUser.displayName,
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      textAlign: TextAlign.left,
                                      style: context.typography.subtitle.bold
                                          .withColor(style.colors.foreground),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  matrixUser.id!,
                                  style: TextStyle(
                                    color:
                                        userRelationship?.pupil != null ||
                                            userRelationship?.isParent == true
                                        ? style.colors.success
                                        : style.colors.accent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          _matrixIconPathFor(userRelationship),
                          width: 24,
                          height: 24,
                          color: userRelationship?.isFamily == true
                              ? style.colors.success
                              : style.colors.accent,
                        ),
                        if (userRelationship?.isParent == true) ...[
                          const Gap(6),
                          ...userRelationship!.familyPupils.map(
                            (pupil) => Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: InkWell(
                                onTap: () {
                                  di<BottomNavManager>().setPupilProfileNavPage(
                                    ProfileNavigationState.info.value,
                                  );
                                  context.push(
                                    RoutePaths.pupilProfilePath(
                                      pupil.internalId,
                                    ),
                                    extra: pupil,
                                  );
                                },
                                borderRadius: BorderRadius.circular(14),
                                child: AvatarWithBadges(pupil: pupil, size: 50),
                              ),
                            ),
                          ),
                        ],
                        const Spacer(),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () async {
                            final confirmation = await confirmationDialog(
                              context: context,
                              title: 'Benutzer:in löschen',
                              message:
                                  'Möchten Sie das Konto wirklich löschen?\nDas kann nicht rückgangig gemacht werden!',
                            );
                            if (confirmation == true) {
                              _matrixPolicyManager.users.deleteUser(
                                userId: matrixUser.id!,
                              );
                            }
                          },
                          icon: Icon(Icons.delete, color: style.colors.error),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: matrixUser.id!),
                            );
                            di<NotificationManager>().showSnackBar(
                              NotificationType.info,
                              'Copied to clipboard',
                            );
                          },
                        ),
                        IconButton(
                          onPressed: () async {
                            final confirmation = await confirmationDialog(
                              context: context,
                              title: 'Passwort zurücksetzen',
                              message:
                                  'Möchten Sie das Passwort wirklich zurücksetzen?',
                            );
                            if (confirmation != true) return;
                            if (!context.mounted) {
                              return;
                            }
                            final logOutDevices = await logoutDevicesDialog(
                              context,
                            );
                            if (logOutDevices == null) return;
                            final file = await _matrixPolicyManager.users
                                .resetPasswordAndPrintCredentialsFile(
                                  user: matrixUser,
                                  logoutDevices: logOutDevices,
                                  isStaff: userRelationship?.isTeacher == true
                                      ? true
                                      : false,
                                );
                            if (file != null) {
                              if (!context.mounted) {
                                return;
                              }
                              context.push(
                                RoutePaths.utilPdfViewer,
                                extra: <String, dynamic>{
                                  'pdfGenerator': () async => file,
                                },
                              );
                            }
                          },
                          icon: const Icon(Icons.qr_code_2_rounded),
                        ),
                        IconButton(
                          onPressed: () =>
                              _showMessageDialog(context, matrixUser),
                          icon: const Icon(Icons.message, color: Colors.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(10),
              InkWell(
                onTap: () => tileController.toggle(),
                child: Column(
                  children: [
                    const Gap(20),
                    const Text('Räume'),
                    Center(
                      child: Text(
                        matrixUser.matrixRooms.length.toString(),
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: style.colors.accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
            ],
          ),
          ExpansionBody(
            title: null,
            tileController: tileController,
            widgetList: [
              if (widget.appUser != null) ...[
                _AppUserInfoSection(appUser: widget.appUser!),
                const Divider(height: 24),
              ],
              GenericAsyncActionButton(
                onPressed: () async {
                  final availableRooms = MatrixRoomHelper.restOfRooms(
                    matrixUser.joinedRooms.map((e) => e.roomId).toList(),
                  );
                  final List<String> selectedRoomIds =
                      await context.push<List<String>>(
                        RoutePaths.adminMatrixSelectRooms,
                        extra: <String, dynamic>{
                          'selectableRooms': availableRooms,
                        },
                      ) ??
                      [];
                  if (selectedRoomIds.isNotEmpty) {
                    final List<JoinedRoom> joinedRooms = selectedRoomIds
                        .map(
                          (roomId) => JoinedRoom(roomId: roomId, powerLevel: 0),
                        )
                        .toList();
                    matrixUser.joinRooms(joinedRooms);
                  }
                },
                title: "RÄUME HINZUFÜGEN",
                buttonType: ButtonType.accept,
              ),

              MatrixUserRoomsList(
                matrixUser: matrixUser,
                matrixRooms: matrixUser.matrixRooms,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AppUserInfoSection extends StatelessWidget {
  final UserWithDevices appUser;

  const _AppUserInfoSection({required this.appUser});

  @override
  Widget build(BuildContext context) {
    final u = appUser.user;
    final info = u.userInfo;
    final devices = appUser.userDevices;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'App-Benutzer',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          if (info != null) ...[
            _InfoRow('Kürzel', info.userName ?? '–'),
            _InfoRow('Name', info.fullName ?? '–'),
            _InfoRow('E-Mail', info.email ?? '–'),

            _InfoRow('Erstellt', info.created.formatDateForUser()),
            const Gap(8),
          ],
          _InfoRow('Rolle', u.role.name),
          _InfoRow('User-ID', '${u.id ?? u.userInfoId}'),
          _InfoRow('Stunden', '${u.timeUnits}'),
          _InfoRow('Entlastung', '${u.reliefTimeUnits}'),
          _InfoRow('Guthaben', '${u.credit}'),
          _InfoRow('Tester', u.userFlags.isTester ? 'Ja' : 'Nein'),
          const Gap(12),
          const Text(
            'Geräte / Sitzungen',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const Gap(6),
          if (devices.isEmpty)
            const Text('Keine Geräte', style: TextStyle(fontSize: 12))
          else
            ...devices.map(
              (d) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.deviceName.isNotEmpty ? d.deviceName : d.deviceId,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Zuletzt: ${d.lastLogin.formatDateForUser()} · '
                            '${d.isActive ? "Aktiv" : "Inaktiv"}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
