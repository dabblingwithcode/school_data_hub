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

class AvatarAuthValues extends WatchingWidget {
  final PupilProxy pupil;
  const AvatarAuthValues({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final _hubSessionManager = di<HubSessionManager>();
    final _notificationService = di<NotificationService>();
    final avatarAuth = watchPropertyValue((m) => m.avatarAuth, target: pupil);
    final avatarAuthId = watchPropertyValue(
      (m) => m.avatarAuthId,
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
      child: Row(
        children: [
          // Status Icon
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: avatarAuth != null
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              avatarAuth != null ? Icons.verified : Icons.cancel,
              color: avatarAuth != null ? Colors.green : Colors.red,
              size: 20,
            ),
          ),
          const Gap(12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Avatar-Einwilligung',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.backgroundColor,
                  ),
                ),
                const Gap(4),
                Text(
                  avatarAuth != null
                      ? 'Einwilligung vorhanden'
                      : 'Keine Einwilligung',
                  style: TextStyle(
                    fontSize: 12,
                    color: avatarAuth != null
                        ? Colors.green.withValues(alpha: 0.8)
                        : Colors.red.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Document Image
          InkWell(
            onTap: () async {
              final File? file = await createAndCropImageFile(context);
              if (file == null) return;
              await PupilMutator().updatePupilDocument(
                imageFile: file,
                pupilProxy: pupil,
                documentType: PupilDocumentType.avatarAuth,
              );
            },
            onLongPress: () async {
              if (_hubSessionManager.isAdmin != true) return;
              if (avatarAuth == null) return;
              final bool? result = await confirmationDialog(
                context: context,
                title: 'Dokument löschen',
                message:
                    'Dokument für die Einwilligung von ${pupil.firstName} ${pupil.lastName} löschen?',
              );
              if (result != true) return;
              await PupilMutator().deletePupilDocument(
                pupil.pupilId,
                avatarAuth.documentId,
                PupilDocumentType.avatarAuth,
              );
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
              child: avatarAuthId != null
                  ? DocumentImage(
                      documentId: avatarAuth!.documentId,
                      size: 50, // Reduced from 70 to 50
                    )
                  : Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.add_a_photo,
                        color: AppColors.backgroundColor.withValues(alpha: 0.6),
                        size: 24,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
