import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/encrypted_document_image.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/multi_choice.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';

class PublicMediaAuthValues extends WatchingWidget {
  final PupilProxy pupil;
  const PublicMediaAuthValues({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final hubSessionManager = di<HubSessionManager>();
    final notificationService = di<NotificationManager>();
    final publicMediaAuth = watchPropertyValue(
      (m) => m.publicMediaAuth,
      target: pupil,
    );
    final publicMediaAuthDocumentId = watchPropertyValue(
      (m) => m.publicMediaAuthDocumentId,
      target: pupil,
    );
    final publicMediaAuthDocument = watchPropertyValue(
      (m) => m.publicMediaAuthDocument,
      target: pupil,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),

      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Style.of(context).colors.cardInCard,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with document upload
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Veröffentlichungseinwilligung',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Style.of(context).colors.accent,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'Bilder, Videos und Namen in Medien',
                        style: TextStyle(
                          fontSize: 12,
                          color: Style.of(context).colors.mutedForeground.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final File? file = await createAndCropImageFile(context);
                    if (file == null) return;
                    await PupilMutator().updatePupilDocument(
                      imageFile: file,
                      pupilProxy: pupil,
                      documentType: PupilDocumentType.publicMediaAuth,
                    );
                  },
                  onLongPress: () async {
                    if (hubSessionManager.isAdmin != true) return;
                    if (publicMediaAuthDocumentId == null) return;
                    final bool? result = await confirmationDialog(
                      context: context,
                      title: 'Dokument löschen',
                      message:
                          'Dokument für die Einwilligung in Veröffentlichungen von ${pupil.firstName} ${pupil.lastName} löschen?\nDie Werte werden zurückgesetzt! ',
                    );
                    if (result != true) return;
                    await PupilMutator().resetPublicMediaAuth(pupil.pupilId);
                    notificationService.showSnackBar(
                      NotificationType.success,
                      'Die Einwilligung wurde geändert!',
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Style.of(context).colors.background,
                          border: Border.all(
                        color: Style.of(context).colors.accent.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                    child: publicMediaAuthDocumentId != null
                        ? EncryptedDocumentImage(
                            documentId: publicMediaAuthDocument!.documentId,
                            size: 40, // Smaller than before
                          )
                        : Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Style.of(context).colors.accent.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              color: Style.of(context).colors.accent.withValues(
                                alpha: 0.6,
                              ),
                              size: 20,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            const Gap(12),

            // Compact authorization grid
            Container(
              padding: EdgeInsets.all(Style.spacing.sm),
              decoration: BoxDecoration(
                color: Style.of(context).colors.background,
                borderRadius: BorderRadius.circular(Style.radii.small),
                border: Border.all(
                  color: Style.of(context).colors.cardInCardBorder,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _buildAuthRow(context,
                    'Gruppenfotos Presse',
                    publicMediaAuth.groupPicturesInPress,
                    publicMediaAuthDocumentId != null,
                    (value) => PupilMutator().updatePublicMediaAuth(
                      pupil: pupil,
                      groupPicturesInPress: value,
                    ),
                  ),
                  _buildAuthRow(context,
                    'Gruppenfotos Website',
                    publicMediaAuth.groupPicturesOnWebsite,
                    publicMediaAuthDocumentId != null,
                    (value) => PupilMutator().updatePublicMediaAuth(
                      pupil: pupil,
                      groupPicturesOnWebsite: value,
                    ),
                  ),
                  _buildAuthRow(context,
                    'Name in Presse',
                    publicMediaAuth.nameInPress,
                    publicMediaAuthDocumentId != null,
                    (value) => PupilMutator().updatePublicMediaAuth(
                      pupil: pupil,
                      nameInPress: value,
                    ),
                  ),
                  _buildAuthRow(context,
                    'Name auf Website',
                    publicMediaAuth.nameOnWebsite,
                    publicMediaAuthDocumentId != null,
                    (value) => PupilMutator().updatePublicMediaAuth(
                      pupil: pupil,
                      nameOnWebsite: value,
                    ),
                  ),
                  _buildAuthRow(context,
                    'Porträtfoto Presse',
                    publicMediaAuth.portraitPicturesInPress,
                    publicMediaAuthDocumentId != null,
                    (value) => PupilMutator().updatePublicMediaAuth(
                      pupil: pupil,
                      portraitPicturesInPress: value,
                    ),
                  ),
                  _buildAuthRow(context,
                    'Porträtfoto Website',
                    publicMediaAuth.portraitPicturesOnWebsite,
                    publicMediaAuthDocumentId != null,
                    (value) => PupilMutator().updatePublicMediaAuth(
                      pupil: pupil,
                      portraitPicturesOnWebsite: value,
                    ),
                    isLast: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthRow(
    BuildContext context,
    String label,
    bool isAllowed,
    bool hasDocument,
    Future<void> Function(bool) onChanged, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Style.of(context).colors.accent,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Deny checkbox
                Container(
                  decoration: BoxDecoration(
                    color: !isAllowed
                        ? Style.of(context).colors.error.withValues(alpha: 0.1)
                        : const Color(0x00000000),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: MultiChoice(
                    value: !isAllowed,
                    onChanged: hasDocument
                        ? (newValue) async {
                            if (newValue == true) {
                              await onChanged(false);
                            }
                          }
                        : null,
                  ),
                ),
                Icon(
                  Icons.close,
                  color: Style.of(context).colors.error.withValues(alpha: 0.7),
                  size: 16,
                ),
                const Gap(8),
                // Allow checkbox
                Container(
                  decoration: BoxDecoration(
                    color: isAllowed
                        ? Style.of(context).colors.success.withValues(alpha: 0.1)
                        : const Color(0x00000000),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: MultiChoice(
                    value: isAllowed,
                    onChanged: hasDocument
                        ? (newValue) async {
                            if (newValue == true && !isAllowed) {
                              await onChanged(true);
                            }
                          }
                        : null,
                  ),
                ),
                Icon(
                  Icons.done,
                  color: Style.of(context).colors.success.withValues(alpha: 0.7),
                  size: 16,
                ),
              ],
            ),
          ],
        ),
        if (!isLast)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            height: 1,
            color: Style.of(context).colors.accent.withValues(alpha: 0.1),
          ),
      ],
    );
  }
}
