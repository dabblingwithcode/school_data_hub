import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_room_helpers.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/select_matrix_rooms_list_page/controller/select_matrix_rooms_list_controller.dart';
import 'package:school_data_hub_flutter/features/matrix/services/matrix_credentials_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

final _matrixPolicyManager = di<MatrixPolicyManager>();
final _pupilManager = di<PupilManager>();

class NewMatrixUserPage extends StatefulWidget {
  final String? matrixId;
  final String? displayName;
  final PupilProxy? pupil;
  final bool? isParent;
  const NewMatrixUserPage({
    super.key,
    this.matrixId,
    this.displayName,
    this.pupil,
    this.isParent,
  });

  @override
  NewMatrixUserPageState createState() => NewMatrixUserPageState();
}

class NewMatrixUserPageState extends State<NewMatrixUserPage> {
  final TextEditingController matrixIdController = TextEditingController();

  final TextEditingController displayNameController = TextEditingController();
  final allRooms = _matrixPolicyManager.matrixRooms.value;

  @override
  void initState() {
    super.initState();
    setState(() {});
    if (widget.matrixId != null) {
      matrixIdController.text = widget.matrixId!;
    }
    if (widget.displayName != null) {
      displayNameController.text = widget.displayName!;
    }
    Set<String> rooms = {};
    if (widget.displayName != null) {
      rooms = MatrixRoomHelper.roomIdsForPupilOrParent(
          widget.displayName!, widget.isParent);
    }

    setState(() {
      roomIds = rooms;
    });
  }

  Set<String> roomIds = {};

  Future<File?> postNewMatrixUser() async {
    String matrixId = '@${matrixIdController.text}:hermannschule.de';

    String displayName = displayNameController.text;

    List<String> roomIdsList = roomIds.toList();
    final isStaff = !matrixId.contains('_');
    final isParent = matrixId.contains('_e');

    // we are getting the credentials pdf file back if the user was created successfully
    // the password is generated in the createNewMatrixUser method
    final file = await _matrixPolicyManager.createNewMatrixUser(
      matrixId: matrixId,
      displayName: displayName,
      isStaff: isStaff,
    );
    // if it is a pupil realated matrix account, we update the corresponding pupil contact field with matrix id
    if (file != null && widget.pupil != null) {
      await _pupilManager.updateStringProperty(
          pupilId: widget.pupil!.pupilId, property: 'contact', value: matrixId);
    }

    _matrixPolicyManager.addMatrixUserToRooms(matrixId, roomIdsList);

    await _matrixPolicyManager.applyPolicyChanges();

    return file;
  }

  @override
  Widget build(BuildContext context) {
    List<MatrixRoom> roomsFromIds =
        MatrixRoomHelper.roomsFromRoomIds(roomIds.toList());
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_rounded,
              size: 25,
              color: Colors.white,
            ),
            Gap(10),
            Text(
              'Neues Matrix-Konto',
              style: AppStyles.appBarTextStyle,
            ),
          ],
        ),
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
                  crossAxisAlignment: CrossAxisAlignment.center, // Add this
                  children: <Widget>[
                    const Text(
                      '@',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(5),
                    SizedBox(
                      width: 160,
                      child: TextField(
                        minLines: 1,
                        maxLines: 3,
                        controller: matrixIdController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.backgroundColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.backgroundColor, width: 2),
                          ),
                          labelStyle:
                              TextStyle(color: AppColors.backgroundColor),
                          labelText: 'Matrix-Id',
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Gap(5),
                    const Text(
                      ':hermannschule.de',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                TextField(
                  minLines: 1,
                  maxLines: 3,
                  controller: displayNameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.backgroundColor, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.backgroundColor, width: 2),
                    ),
                    labelStyle: TextStyle(color: AppColors.backgroundColor),
                    labelText: 'Anzeigename',
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Row(
                  children: [
                    const Text(
                      'Ausgewählte Räume:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Gap(10),
                    Text(
                      roomsFromIds.length.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
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
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: roomsFromIds.length,
                                itemBuilder: (context, int index) {
                                  MatrixRoom listedRoom = roomsFromIds[index];
                                  return Column(
                                    children: [
                                      Card(
                                        color: Colors.white,
                                        child: SizedBox(
                                          height: 60,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  listedRoom.name!,
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    roomIds
                                                        .remove(listedRoom.id);
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: AppColors.accentColor,
                                                ),
                                              ),
                                              const Gap(10),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Keine Räume ausgewählt!',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 91, 91, 91),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                if (roomIds.isEmpty) const Spacer(),
                ElevatedButton(
                  style: AppStyles.actionButtonStyle,
                  onPressed: () async {
                    final List<String> selectedRoomIds =
                        await Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => SelectMatrixRoomsList(
                                  MatrixRoomHelper.restOfRooms(
                                      roomIds.toList())),
                            )) ??
                            [];
                    if (selectedRoomIds.isNotEmpty) {
                      setState(() {
                        roomIds.addAll(selectedRoomIds.toSet());
                      });
                    }
                  },
                  child: const Text(
                    'RÄUME HINZUFÜGEN',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
                const Gap(15),
                ElevatedButton(
                  style: AppStyles.successButtonStyle,
                  onPressed: () async {
                    final file = await postNewMatrixUser();

                    if (file != null && context.mounted) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PdfViewPage(pdfFile: file),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'SENDEN',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
                const Gap(15),
                ElevatedButton(
                  style: AppStyles.cancelButtonStyle,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'ABBRECHEN',
                    style: AppStyles.buttonTextStyle,
                  ),
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
    // Clean up the controller when the widget is removed from the tree
    matrixIdController.dispose();
    displayNameController.dispose();
    super.dispose();
  }
}
