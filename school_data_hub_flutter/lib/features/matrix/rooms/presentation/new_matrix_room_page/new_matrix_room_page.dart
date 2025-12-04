import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/data/matrix_room_api_service.dart';
import 'package:watch_it/watch_it.dart';

class NewMatrixRoomPage extends StatefulWidget {
  const NewMatrixRoomPage({super.key});

  @override
  State<NewMatrixRoomPage> createState() => _NewMatrixRoomPageState();
}

class _NewMatrixRoomPageState extends State<NewMatrixRoomPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController topicController = TextEditingController();
  final TextEditingController aliasController = TextEditingController();

  ChatTypePreset selectedRoomType = ChatTypePreset.private;
  bool isProcessing = false;

  MatrixPolicyManager get _matrixPolicyManager => di<MatrixPolicyManager>();
  NotificationService get _notificationService => di<NotificationService>();

  @override
  void dispose() {
    nameController.dispose();
    topicController.dispose();
    aliasController.dispose();
    super.dispose();
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
        aliasName:
            aliasController.text.trim().isEmpty
                ? null
                : aliasController.text.trim(),
        chatTypePreset: selectedRoomType,
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
                                  value: selectedRoomType,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [
                                    const DropdownMenuItem(
                                      value: ChatTypePreset.private,
                                      child: const Text('Privat'),
                                    ),
                                    const DropdownMenuItem(
                                      value: ChatTypePreset.public,
                                      child: const Text('Öffentlich'),
                                    ),
                                    const DropdownMenuItem(
                                      value: ChatTypePreset.trustedPrivate,
                                      child: const Text(
                                        'Vertrauenswürdig Privat',
                                      ),
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
                      ],
                    ),
                  ),
                ),

                const Gap(16),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Cancel button - with constrained width
                      SizedBox(
                        width: 150, // Fixed width
                        child: ElevatedButton(
                          style: AppStyles.cancelButtonStyle,
                          onPressed:
                              isProcessing
                                  ? null
                                  : () => Navigator.of(context).pop(),
                          child: const Text(
                            'ABBRECHEN',
                            style: AppStyles.buttonTextStyle,
                          ),
                        ),
                      ),

                      // Create button - with constrained width
                      SizedBox(
                        width: 150, // Fixed width
                        child: ElevatedButton(
                          style: AppStyles.successButtonStyle,
                          onPressed: isProcessing ? null : createRoom,
                          child:
                              isProcessing
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
}
