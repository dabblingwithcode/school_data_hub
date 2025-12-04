import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/document_image.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:watch_it/watch_it.dart';

class PublicMediaAuthValues extends WatchingWidget {
  final PupilProxy pupil;
  const PublicMediaAuthValues({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final _hubSessionManager = di<HubSessionManager>();
    final _notificationService = di<NotificationService>();
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

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.backgroundColor.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.backgroundColor.withValues(alpha: 0.08),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
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
                    const Text(
                      'Veröffentlichungseinwilligung',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'Bilder, Videos und Namen in Medien',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
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
                  if (_hubSessionManager.isAdmin != true) return;
                  if (publicMediaAuthDocumentId == null) return;
                  final bool? result = await confirmationDialog(
                    context: context,
                    title: 'Dokument löschen',
                    message:
                        'Dokument für die Einwilligung in Veröffentlichungen von ${pupil.firstName} ${pupil.lastName} löschen?\nDie Werte werden zurückgesetzt! ',
                  );
                  if (result != true) return;
                  await PupilMutator().resetPublicMediaAuth(pupil.pupilId);
                  _notificationService.showSnackBar(
                    NotificationType.success,
                    'Die Einwilligung wurde geändert!',
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.backgroundColor.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: publicMediaAuthDocumentId != null
                      ? DocumentImage(
                          documentId: publicMediaAuthDocument!.documentId,
                          size: 40, // Smaller than before
                        )
                      : Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.add_a_photo,
                            color: AppColors.backgroundColor.withValues(
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.backgroundColor.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                _buildAuthRow(
                  'Gruppenfotos Presse',
                  publicMediaAuth.groupPicturesInPress,
                  publicMediaAuthDocumentId != null,
                  (value) => PupilMutator().updatePublicMediaAuth(
                    pupil: pupil,
                    groupPicturesInPress: value,
                  ),
                ),
                _buildAuthRow(
                  'Gruppenfotos Website',
                  publicMediaAuth.groupPicturesOnWebsite,
                  publicMediaAuthDocumentId != null,
                  (value) => PupilMutator().updatePublicMediaAuth(
                    pupil: pupil,
                    groupPicturesOnWebsite: value,
                  ),
                ),
                _buildAuthRow(
                  'Name in Presse',
                  publicMediaAuth.nameInPress,
                  publicMediaAuthDocumentId != null,
                  (value) => PupilMutator().updatePublicMediaAuth(
                    pupil: pupil,
                    nameInPress: value,
                  ),
                ),
                _buildAuthRow(
                  'Name auf Website',
                  publicMediaAuth.nameOnWebsite,
                  publicMediaAuthDocumentId != null,
                  (value) => PupilMutator().updatePublicMediaAuth(
                    pupil: pupil,
                    nameOnWebsite: value,
                  ),
                ),
                _buildAuthRow(
                  'Porträtfoto Presse',
                  publicMediaAuth.portraitPicturesInPress,
                  publicMediaAuthDocumentId != null,
                  (value) => PupilMutator().updatePublicMediaAuth(
                    pupil: pupil,
                    portraitPicturesInPress: value,
                  ),
                ),
                _buildAuthRow(
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
    );
  }

  Widget _buildAuthRow(
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
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.backgroundColor,
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
                        ? Colors.red.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Transform.scale(
                    scale: 0.8,
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: !isAllowed,
                      activeColor: Colors.red,
                      onChanged: hasDocument
                          ? (newValue) async {
                              if (newValue == true) {
                                await onChanged(false);
                              }
                            }
                          : null,
                    ),
                  ),
                ),
                Icon(
                  Icons.close,
                  color: Colors.red.withValues(alpha: 0.7),
                  size: 16,
                ),
                const Gap(8),
                // Allow checkbox
                Container(
                  decoration: BoxDecoration(
                    color: isAllowed
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Transform.scale(
                    scale: 0.8,
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: isAllowed,
                      activeColor: Colors.green,
                      onChanged: hasDocument
                          ? (newValue) async {
                              if (newValue == true && !isAllowed) {
                                await onChanged(true);
                              }
                            }
                          : null,
                    ),
                  ),
                ),
                Icon(
                  Icons.done,
                  color: Colors.green.withValues(alpha: 0.7),
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
            color: AppColors.backgroundColor.withValues(alpha: 0.1),
          ),
      ],
    );
  }
}
