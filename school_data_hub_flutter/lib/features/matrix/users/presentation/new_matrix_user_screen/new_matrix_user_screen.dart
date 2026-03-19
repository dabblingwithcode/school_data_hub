import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/matrix_room_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/select_matrix_rooms_list_page/controller/select_matrix_rooms_list_controller.dart';

class NewMatrixUserScreen extends StatefulWidget {
  final String? matrixId;
  final String? displayName;
  final PupilProxy? pupil;
  final bool? isParent;
  const NewMatrixUserScreen({
    super.key,
    this.matrixId,
    this.displayName,
    this.pupil,
    this.isParent,
  });

  @override
  NewMatrixUserScreenState createState() => NewMatrixUserScreenState();
}

class NewMatrixUserScreenState extends State<NewMatrixUserScreen> {
  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return FutureBuilder(
      future: di.getAsync<MatrixPolicyManager>(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: style.colors.canvas,
            appBar: const AppHeader(
              iconData: Icons.chat_rounded,
              title: 'Neues Matrix-Konto',
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bitte warten',
                    style: context.typography.subtitle.bold,
                  ),
                  const Gap(20),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }

        return _NewMatrixUserScreenContent(
          matrixPolicyManager: snapshot.data!,
          matrixId: widget.matrixId,
          displayName: widget.displayName,
          pupil: widget.pupil,
          isParent: widget.isParent,
        );
      },
    );
  }
}

class _NewMatrixUserScreenContent extends StatefulWidget {
  final MatrixPolicyManager matrixPolicyManager;
  final String? matrixId;
  final String? displayName;
  final PupilProxy? pupil;
  final bool? isParent;

  const _NewMatrixUserScreenContent({
    required this.matrixPolicyManager,
    this.matrixId,
    this.displayName,
    this.pupil,
    this.isParent,
  });

  @override
  _NewMatrixUserScreenContentState createState() =>
      _NewMatrixUserScreenContentState();
}

class _NewMatrixUserScreenContentState extends State<_NewMatrixUserScreenContent> {
  final TextEditingController matrixIdController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  Set<String> roomIds = {};

  @override
  void initState() {
    super.initState();
    if (widget.matrixId != null) {
      matrixIdController.text = widget.matrixId!;
    }
    if (widget.displayName != null) {
      displayNameController.text = widget.displayName!;
    }
    Set<String> rooms = {};
    if (widget.displayName != null) {
      rooms = MatrixRoomHelper.setOfSchoolAssignedRoomIdsForPupilOrParent(
        matrixUserDisplayName: widget.displayName!,
        isParent: widget.isParent,
      );
    }

    roomIds = rooms;
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    List<MatrixRoom> roomsFromIds = MatrixRoomHelper.roomsFromRoomIds(
      roomIds.toList(),
    );
    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.chat_rounded,
        title: 'Neues Matrix-Konto',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '@',
                      style: context.typography.body.bold,
                    ),
                    const Gap(5),
                    SizedBox(
                      width: 160,
                      child: TextField(
                        minLines: 1,
                        maxLines: 3,
                        controller: matrixIdController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: style.colors.accent,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: style.colors.accent,
                              width: 2,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: style.colors.accent,
                          ),
                          labelText: 'Matrix-Id',
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Gap(5),
                    Text(
                      ':${widget.matrixPolicyManager.matrixUrl.split('://').last}',
                      style: context.typography.body.bold,
                    ),
                  ],
                ),
                const Gap(20),
                TextField(
                  minLines: 1,
                  maxLines: 3,
                  controller: displayNameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: style.colors.accent,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: style.colors.accent,
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(color: style.colors.accent),
                    labelText: 'Anzeigename',
                  ),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                Row(
                  children: [
                    Text(
                      'Ausgewählte Räume:',
                      style: context.typography.body.bold,
                    ),
                    const Gap(10),
                    Text(
                      roomsFromIds.length.toString(),
                      style: context.typography.subtitle.bold,
                    ),
                  ],
                ),
                if (roomIds.isEmpty) const Gap(30),
                roomIds.isNotEmpty
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: roomsFromIds.length,
                              itemBuilder: (context, int index) {
                                MatrixRoom listedRoom = roomsFromIds[index];
                                return Column(
                                  children: [
                                    Card(
                                      color: style.colors.background,
                                      child: SizedBox(
                                        height: 60,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                15.0,
                                              ),
                                              child: Text(
                                                listedRoom.name!,
                                                style: context.typography.body.bold,
                                              ),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  roomIds.remove(listedRoom.id);
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: style.colors.error,
                                              ),
                                            ),
                                            const Gap(10),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Keine Räume ausgewählt!',
                            style: context.typography.subtitle.bold.withColor(
                              style.colors.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                if (roomIds.isEmpty) const Spacer(),
                Button(
                  variant: ButtonVariant.primary,
                  onPressed: () async {
                    final List<String> selectedRoomIds =
                        await Navigator.of(context).push(
                          MaterialPageRoute<List<String>>(
                            builder: (ctx) => SelectMatrixRoomsList(
                              MatrixRoomHelper.restOfRooms(roomIds.toList()),
                            ),
                          ),
                        ) ??
                        [];
                    if (selectedRoomIds.isNotEmpty) {
                      setState(() {
                        roomIds.addAll(selectedRoomIds.toSet());
                      });
                    }
                  },
                  label: 'RÄUME HINZUFÜGEN',
                ),
                const Gap(15),
                Button(
                  variant: ButtonVariant.primary,
                  onPressed: () async {
                    final file = await widget.matrixPolicyManager.users
                        .postNewMatrixUser(
                          pupil: widget.pupil,
                          generatedMatrixId: matrixIdController.text,
                          displayName: displayNameController.text,
                          roomIds: roomIds.toList(),
                        );

                    if (file != null && context.mounted) {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => PdfViewerScreen(pdfGenerator: () async => file),
                        ),
                      );
                    }
                  },
                  label: 'SENDEN',
                ),
                const Gap(15),
                Button(
                  variant: ButtonVariant.destructive,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: 'ABBRECHEN',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    matrixIdController.dispose();
    displayNameController.dispose();
    super.dispose();
  }
}
