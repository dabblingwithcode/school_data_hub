import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/data/matrix_room_api_service.dart';

class NewMatrixRoomPage extends StatefulWidget {
  const NewMatrixRoomPage({super.key});

  @override
  State<NewMatrixRoomPage> createState() => _NewMatrixRoomPageState();
}

class _NewMatrixRoomPageState extends State<NewMatrixRoomPage> {
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
  NotificationService get _notificationService => di<NotificationService>();

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
      _notificationService.showInformationDialog(e.toString());
      _notificationService.showSnackBar(
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
      _notificationService.showInformationDialog(e.toString());
      _notificationService.showSnackBar(
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
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.meeting_room_rounded, size: 25, color: Colors.white),
            Gap(10),
            Text('Neuer Matrix-Raum', style: AppStyles.appBarTextStyle),
          ],
        ),
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
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Bestehenden Raum zur Policy hinzufügen',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Gap(8),
                                const Text(
                                  'Matrix-Raum-ID eingeben (z.B. !abc123:server.de)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
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
                                ElevatedButton(
                                  style: AppStyles.successButtonStyle,
                                  onPressed: isAddingExisting
                                      ? null
                                      : addExistingRoom,
                                  child: isAddingExisting
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          'Zur Policy hinzufügen',
                                          style: AppStyles.buttonTextStyle,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(16),
                        // Room name field
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Raum-Name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Thema',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Alias (optional)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                const Text(
                                  'Der Alias darf keine Leerzeichen oder Sonderzeichen enthalten.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(16),

                        // Room type selection
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Raumtyp',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                          color: Colors.white,
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
                                    const Text(
                                      'Als Pflichtraum markieren',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                      // Cancel button - with constrained width
                      ElevatedButton(
                        style: AppStyles.cancelButtonStyle,
                        onPressed: isProcessing
                            ? null
                            : () => Navigator.of(context).pop(),
                        child: const Text(
                          'ABBRECHEN',
                          style: AppStyles.buttonTextStyle,
                        ),
                      ),
                      const Gap(10),
                      // Create button - with constrained width
                      ElevatedButton(
                        style: AppStyles.successButtonStyle,
                        onPressed: isProcessing ? null : createRoom,
                        child: isProcessing
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'RAUM ERSTELLEN',
                                style: AppStyles.buttonTextStyle,
                              ),
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
      style: const TextStyle(fontSize: 12, color: Colors.grey),
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
