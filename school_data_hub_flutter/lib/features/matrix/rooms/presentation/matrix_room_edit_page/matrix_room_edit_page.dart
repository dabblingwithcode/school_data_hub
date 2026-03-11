// ignore_for_file: unused_field

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/generic_async_action_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/dialogs/remove_room_from_policy_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_rooms_list_page/widgets/change_power_levels_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_rooms_list_page/widgets/users_in_room_list.dart';

class MatrixRoomEditPage extends WatchingStatefulWidget {
  final MatrixRoom room;

  const MatrixRoomEditPage({required this.room, super.key});

  @override
  State<MatrixRoomEditPage> createState() => _MatrixRoomEditPageState();
}

class _MatrixRoomEditPageState extends State<MatrixRoomEditPage> {
  final _nameController = TextEditingController();
  final _topicController = TextEditingController();
  final _aliasController = TextEditingController();

  bool _isLoadingMeta = false;
  bool _isSaving = false;

  String _initialName = '';
  String _initialTopic = '';
  String _initialAlias = '';

  MatrixPolicyManager get _matrixPolicyManager => di<MatrixPolicyManager>();

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
      '$matrixBaseUrl/_matrix/client/v1/media/thumbnail/$server/$mediaId?width=160&height=160&method=crop',
      '$matrixBaseUrl/_matrix/media/v3/thumbnail/$server/$mediaId?width=160&height=160&method=crop',
      '$matrixBaseUrl/_matrix/media/r0/thumbnail/$server/$mediaId?width=160&height=160&method=crop',
    ];
  }

  @override
  void initState() {
    super.initState();
    _initialName = widget.room.name ?? '';
    _nameController.text = _initialName;
    _loadRoomMeta();
  }

  Future<void> _loadRoomMeta() async {
    setState(() {
      _isLoadingMeta = true;
    });

    final topic = await _matrixPolicyManager.rooms.fetchRoomTopic(
      roomId: widget.room.id,
    );
    final alias = await _matrixPolicyManager.rooms.fetchRoomCanonicalAlias(
      roomId: widget.room.id,
    );

    if (!mounted) {
      return;
    }

    _initialTopic = topic ?? '';
    _initialAlias = alias ?? '';
    _topicController.text = _initialTopic;
    _aliasController.text = _initialAlias;

    setState(() {
      _isLoadingMeta = false;
    });
  }

  Future<void> _saveRoomValues() async {
    final name = _nameController.text.trim();
    final topic = _topicController.text.trim();
    final alias = _aliasController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte einen Raumnamen angeben.')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    if (name != _initialName) {
      await _matrixPolicyManager.rooms.setRoomName(
        roomId: widget.room.id,
        name: name,
      );
      _initialName = name;
    }

    if (topic != _initialTopic) {
      await _matrixPolicyManager.rooms.setRoomTopic(
        roomId: widget.room.id,
        topic: topic,
      );
      _initialTopic = topic;
    }

    final normalizedAlias = alias;
    if (normalizedAlias != _initialAlias) {
      await _matrixPolicyManager.rooms.setRoomCanonicalAlias(
        roomId: widget.room.id,
        alias: normalizedAlias.isEmpty ? null : normalizedAlias,
      );
      _initialAlias = normalizedAlias;
    }

    if (mounted) {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _pickAndSetAvatar(MatrixRoom room) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result == null || result.files.isEmpty) {
      return;
    }

    final file = result.files.first;
    final bytes = file.bytes;
    final fileName = file.name;

    if (bytes == null || fileName.isEmpty) {
      return;
    }

    await _matrixPolicyManager.rooms.setRoomAvatar(
      roomId: room.id,
      fileBytes: bytes,
      fileName: fileName,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _topicController.dispose();
    _aliasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final room = watch<MatrixRoom>(widget.room);
    final bool pendingChanges = watchValue(
      (MatrixPolicyManager x) => x.pendingChanges,
    );
    final roomAvatarUrls = _toMediaThumbnailUrls(
      avatarUrl: room.avatarUrl,
      matrixBaseUrl: _matrixPolicyManager.matrixUrl,
    );
    final imageHeaders = {'Authorization': _matrixPolicyManager.matrixToken};
    final primaryAvatarUrl = roomAvatarUrls.isNotEmpty
        ? roomAvatarUrls[0]
        : null;
    final fallbackAvatarUrl = roomAvatarUrls.length > 1
        ? roomAvatarUrls[1]
        : null;

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        title: 'Raum bearbeiten',
        iconData: Icons.room_rounded,
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned.fill(
                                    child: ClipOval(
                                      child: primaryAvatarUrl != null
                                          ? Image.network(
                                              primaryAvatarUrl,
                                              fit: BoxFit.cover,
                                              headers: imageHeaders,
                                              errorBuilder: (_, __, ___) =>
                                                  fallbackAvatarUrl != null
                                                  ? Image.network(
                                                      fallbackAvatarUrl,
                                                      fit: BoxFit.cover,
                                                      headers: imageHeaders,
                                                      errorBuilder:
                                                          (
                                                            _,
                                                            __,
                                                            ___,
                                                          ) => Container(
                                                            color: Colors
                                                                .grey
                                                                .shade300,
                                                            alignment: Alignment
                                                                .center,
                                                            child: const Icon(
                                                              Icons.group,
                                                              size: 18,
                                                            ),
                                                          ),
                                                    )
                                                  : Container(
                                                      color:
                                                          Colors.grey.shade300,
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Icon(
                                                        Icons.group,
                                                        size: 18,
                                                      ),
                                                    ),
                                            )
                                          : Container(
                                              color: Colors.grey.shade300,
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.group,
                                                size: 18,
                                              ),
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    right: -8,
                                    bottom: -8,
                                    child: Material(
                                      color: AppColors.interactiveColor,
                                      shape: const CircleBorder(),
                                      child: SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          tooltip: 'Avatar setzen',
                                          onPressed: () =>
                                              _pickAndSetAvatar(room),
                                          icon: const Icon(
                                            Icons.add_a_photo_outlined,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: TextField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(15),
                        TextField(
                          controller: _topicController,
                          decoration: const InputDecoration(
                            labelText: 'Thema',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 2,
                        ),
                        const Gap(10),
                        TextField(
                          controller: _aliasController,
                          decoration: const InputDecoration(
                            labelText: 'Canonical Alias',
                            hintText: '#raum:domain',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const Gap(8),
                        Row(
                          children: [
                            Expanded(
                              child: SelectableText(
                                'Room ID: ${room.id}',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            IconButton(
                              tooltip: 'Room ID kopieren',
                              icon: const Icon(Icons.copy),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: room.id));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'In die Zwischenablage kopiert',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const Gap(8),
                        GenericAsyncActionButton(
                          onPressed: _saveRoomValues,
                          title: 'WERTE SPEICHERN',
                          buttonType: ButtonType.accept,
                          icon: Icons.save,
                        ),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: ElevatedButton.icon(
                        //     style: AppStyles.successButtonStyle,
                        //     onPressed: _isSaving || _isLoadingMeta
                        //         ? null
                        //         : _saveRoomValues,
                        //     icon: _isSaving
                        //         ? const SizedBox(
                        //             width: 16,
                        //             height: 16,
                        //             child: CircularProgressIndicator(
                        //               strokeWidth: 2,
                        //               color: Colors.white,
                        //             ),
                        //           )
                        //         : const Icon(Icons.save),
                        //     label: const Text(
                        //       'WERTE SPEICHERN',
                        //       style: AppStyles.buttonTextStyle,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                const Gap(12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Berechtigungen',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Gap(8),
                        Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Schreiben: '),
                                InkWell(
                                  onTap: () async {
                                    final int? newPowerLevel =
                                        await changePowerLevelsDialog(context);
                                    if (newPowerLevel == null ||
                                        newPowerLevel < 0) {
                                      return;
                                    }
                                    _matrixPolicyManager.rooms
                                        .changeRoomPowerLevels(
                                          roomId: room.id,
                                          eventsDefault: newPowerLevel,
                                        );
                                  },
                                  child: Text(
                                    room.eventsDefault?.toString() ?? '0',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.interactiveColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Reaktionen: '),
                                InkWell(
                                  onTap: () async {
                                    final int? newPowerLevel =
                                        await changePowerLevelsDialog(context);
                                    if (newPowerLevel == null ||
                                        newPowerLevel < 0) {
                                      return;
                                    }
                                    _matrixPolicyManager.rooms
                                        .changeRoomPowerLevels(
                                          roomId: room.id,
                                          reactions: newPowerLevel,
                                        );
                                  },
                                  child: Text(
                                    room.powerLevelReactions?.toString() ?? '0',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.interactiveColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Konten im Raum',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Gap(8),
                        MatrixUsersInRoomList(room: room),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          if (pendingChanges) ...[
            const Gap(20),
            IconButton(
              tooltip: 'Änderungen speichern',
              icon: const Icon(Icons.save, size: 30),
              onPressed: () {
                _matrixPolicyManager.applyPolicyChanges();
              },
            ),
          ],
          const Gap(20),
          IconButton(
            tooltip: 'Aus Policy entfernen',
            icon: const Icon(Icons.delete_rounded, size: 30, color: Colors.red),
            onPressed: () async {
              final result = await showRemoveRoomFromPolicyDialog(
                context,
                roomName: room.name ?? room.id,
              );
              if (result != null) {
                await _matrixPolicyManager.rooms.removeManagedRoom(
                  room,
                  purgeRoom: result.purge,
                );
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
