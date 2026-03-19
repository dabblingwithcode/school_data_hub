import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/data/matrix_room_api_service.dart';

class NewMatrixRoomScreen extends StatefulWidget {
  const NewMatrixRoomScreen({super.key});

  @override
  State<NewMatrixRoomScreen> createState() => _NewMatrixRoomScreenState();
}

class _NewMatrixRoomScreenState extends State<NewMatrixRoomScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController topicController = TextEditingController();
  final TextEditingController aliasController = TextEditingController();
  final TextEditingController existingRoomIdController =
      TextEditingController();

  ChatTypePreset selectedRoomType = ChatTypePreset.private;
  bool markAsCompulsory = false;
  MatrixRoomType compulsoryRoomType = MatrixRoomType.other;
  bool isProcessing = false;
  bool isAddingExisting = false;

  MatrixPolicyManager get _matrixPolicyManager => di<MatrixPolicyManager>();
  NotificationManager get _notificationService => di<NotificationManager>();

  @override
  void dispose() {
    nameController.dispose();
    topicController.dispose();
    aliasController.dispose();
    existingRoomIdController.dispose();
    super.dispose();
  }

  Future<void> addExistingRoom() async {
    setState(() {
      isAddingExisting = true;
    });
    try {
      await _matrixPolicyManager.rooms.addExistingRoomById(
        existingRoomIdController.text,
      );
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      _notificationService.showInformationDialog(
        NotificationType.error,
        'Fehler beim Hinzufügen des Raums: ${e.toString()}',
      );
    } finally {
      if (mounted) {
        setState(() {
          isAddingExisting = false;
        });
      }
    }
  }

  Future<void> createRoom() async {
    if (nameController.text.trim().isEmpty) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Bitte geben Sie einen Namen für den Raum ein',
      );
      return;
    }

    if (topicController.text.trim().isEmpty) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Bitte geben Sie ein Thema für den Raum ein',
      );
      return;
    }

    setState(() {
      isProcessing = true;
    });

    try {
      await _matrixPolicyManager.rooms.createNewRoom(
        name: nameController.text.trim(),
        topic: topicController.text.trim(),
        aliasName: aliasController.text.trim().isEmpty
            ? null
            : aliasController.text.trim(),
        chatTypePreset: selectedRoomType,
        markAsCompulsoryWithType: markAsCompulsory ? compulsoryRoomType : null,
      );

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      _notificationService.showInformationDialog(
        NotificationType.error,
        'Fehler beim Erstellen des Raums: ${e.toString()}',
      );
    } finally {
      if (mounted) {
        setState(() {
          isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.meeting_room_rounded,
        title: 'Neuer Matrix-Raum',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Add existing room by ID
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bestehenden Raum zur Policy hinzufügen',
                                  style: context.typography.subtitle.bold,
                                ),
                                const Gap(8),
                                Text(
                                  'Matrix-Raum-ID eingeben (z.B. !abc123:server.de)',
                                  style: context.typography.bodySmall
                                      .withColor(style.colors.mutedForeground),
                                ),
                                const Gap(8),
                                TextField(
                                  controller: existingRoomIdController,
                                  decoration: const InputDecoration(
                                    hintText: '!abc123:server.de',
                                    border: OutlineInputBorder(),
                                  ),
                                  enabled: !isAddingExisting,
                                ),
                                const Gap(8),
                                Button(
                                  variant: ButtonVariant.primary,
                                  onPressed: isAddingExisting
                                      ? null
                                      : addExistingRoom,
                                  loading: isAddingExisting,
                                  label: 'Zur Policy hinzufügen',
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(16),
                        // Room name field
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Raum-Name',
                                  style: context.typography.subtitle.bold,
                                ),
                                const Gap(8),
                                TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    hintText: 'z.B. Klasse 3a',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(16),

                        // Room topic field
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Thema',
                                  style: context.typography.subtitle.bold,
                                ),
                                const Gap(8),
                                TextField(
                                  controller: topicController,
                                  decoration: const InputDecoration(
                                    hintText: 'Beschreibung des Raums',
                                    border: OutlineInputBorder(),
                                  ),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(16),

                        // Room alias field
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Alias (optional)',
                                  style: context.typography.subtitle.bold,
                                ),
                                const Gap(8),
                                TextField(
                                  controller: aliasController,
                                  decoration: const InputDecoration(
                                    hintText: 'z.B. klasse3a',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  'Der Alias darf keine Leerzeichen oder Sonderzeichen enthalten.',
                                  style: context.typography.bodySmall
                                      .withColor(style.colors.mutedForeground),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(16),

                        // Room type selection
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Raumtyp',
                                  style: context.typography.subtitle.bold,
                                ),
                                const Gap(16),
                                DropdownButtonFormField<ChatTypePreset>(
                                  initialValue: selectedRoomType,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [
                                    const DropdownMenuItem(
                                      value: ChatTypePreset.private,
                                      child: Text('Privat'),
                                    ),
                                    const DropdownMenuItem(
                                      value: ChatTypePreset.public,
                                      child: Text('Öffentlich'),
                                    ),
                                    const DropdownMenuItem(
                                      value: ChatTypePreset.trustedPrivate,
                                      child: Text('Vertrauenswürdig Privat'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRoomType = value!;
                                    });
                                  },
                                ),
                                const Gap(8),
                                _buildRoomTypeDescription(),
                              ],
                            ),
                          ),
                        ),
                        const Gap(16),
                        // Mark as compulsory room
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: markAsCompulsory,
                                      onChanged: (value) {
                                        setState(() {
                                          markAsCompulsory = value ?? false;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Als Pflichtraum markieren',
                                      style: context.typography.subtitle.bold,
                                    ),
                                  ],
                                ),
                                if (markAsCompulsory) ...[
                                  const Gap(8),
                                  DropdownButtonFormField<MatrixRoomType>(
                                    initialValue: compulsoryRoomType,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    items: MatrixRoomType.values
                                        .map(
                                          (t) => DropdownMenuItem(
                                            value: t,
                                            child: Text(
                                              _compulsoryRoomTypeLabel(t),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        setState(() {
                                          compulsoryRoomType = value;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(16),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Cancel button
                      Button(
                        variant: ButtonVariant.destructive,
                        onPressed: isProcessing
                            ? null
                            : () => Navigator.of(context).pop(),
                        label: 'ABBRECHEN',
                      ),
                      const Gap(10),
                      // Create button
                      Button(
                        variant: ButtonVariant.primary,
                        onPressed: isProcessing ? null : createRoom,
                        loading: isProcessing,
                        label: 'RAUM ERSTELLEN',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoomTypeDescription() {
    final style = Style.of(context);
    String description;

    switch (selectedRoomType) {
      case ChatTypePreset.private:
        description =
            'Private Räume sind nur für eingeladene Benutzer sichtbar und zugänglich.';
        break;
      case ChatTypePreset.public:
        description =
            'Öffentliche Räume sind für alle Benutzer sichtbar und zugänglich.';
        break;
      case ChatTypePreset.trustedPrivate:
        description =
            'Vertrauenswürdige private Räume sind nur für eingeladene Benutzer zugänglich, mit erhöhten Berechtigungen für alle Mitglieder.';
        break;
    }

    return Text(
      description,
      style: context.typography.bodySmall
          .withColor(style.colors.mutedForeground),
    );
  }

  static String _compulsoryRoomTypeLabel(MatrixRoomType t) {
    switch (t) {
      case MatrixRoomType.contacts:
        return 'Kontakte';
      case MatrixRoomType.globalParents:
        return 'Eltern global';
      case MatrixRoomType.globalChildrem:
        return 'Kinder global';
      case MatrixRoomType.globalTeacher:
        return 'Lehrer global';
      case MatrixRoomType.groupChildren:
        return 'Kinder Gruppe';
      case MatrixRoomType.groupParents:
        return 'Eltern Gruppe';
      case MatrixRoomType.staff:
        return 'Mitarbeiter';
      case MatrixRoomType.other:
        return 'Sonstige';
    }
  }
}
