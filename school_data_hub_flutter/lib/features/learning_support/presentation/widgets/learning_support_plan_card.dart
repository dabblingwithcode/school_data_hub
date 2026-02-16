import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/controller/new_learning_support_plan_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/learning_support_plan_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

/// A display-only card for a learning support plan.
///
/// Shows plan details and provides an edit button that navigates to the
/// [NewLearningSupportPlan] page in edit mode, and a PDF generation button.
/// Encrypted fields (comment, strengthsDescription, problemsDescription)
/// are decrypted once at build time.
class LearningSupportPlanCard extends StatelessWidget {
  final LearningSupportPlan plan;
  final PupilProxy pupil;

  const LearningSupportPlanCard({
    required this.plan,
    required this.pupil,
    super.key,
  });

  void _editPlan(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            NewLearningSupportPlan(pupil: pupil, existingPlan: plan),
      ),
    );
  }

  Future<void> _generatePlanPdf(BuildContext context) async {
    try {
      final supportCategoryManager = di<SupportCategoryManager>();
      final supportCategories = supportCategoryManager.supportCategories.value;

      final file =
          await LearningSupportPlanPdfGenerator.generateLearningSupportPlanPdf(
            plan: plan,
            pupil: pupil,
            supportCategories: supportCategories,
          );

      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => LearningSupportPlanPdfViewPage(pdfFile: file),
          ),
        );
      }
    } catch (e) {
      di<NotificationService>().showSnackBar(
        NotificationType.error,
        'Fehler beim Erstellen des PDFs: $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Decrypt encrypted fields once for display
    final decryptedComment = plan.comment != null
        ? customEncrypter.decryptString(plan.comment!)
        : null;
    final decryptedStrengths = plan.strengthsDescription != null
        ? customEncrypter.decryptString(plan.strengthsDescription!)
        : null;
    final decryptedProblems = plan.problemsDescription != null
        ? customEncrypter.decryptString(plan.problemsDescription!)
        : null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const Gap(8),
            _buildCreatedInfo(),
            _buildDisplayMode(
              decryptedComment: decryptedComment,
              decryptedStrengths: decryptedStrengths,
              decryptedProblems: decryptedProblems,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Förderplan Nr. ${plan.number}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Gap(10),
        InkWell(
          onTap: () => _editPlan(context),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.interactiveColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: AppColors.interactiveColor.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              Icons.edit,
              size: 20,
              color: AppColors.interactiveColor,
            ),
          ),
        ),
        const Gap(6),
        InkWell(
          onTap: () => _generatePlanPdf(context),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: AppColors.accentColor.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              Icons.picture_as_pdf,
              size: 20,
              color: AppColors.accentColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreatedInfo() {
    return Row(
      children: [
        const Icon(Icons.person, size: 16, color: Colors.grey),
        const Gap(4),
        Text(
          'Erstellt von: ${plan.createdBy}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const Spacer(),
        const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
        const Gap(4),
        Text(
          '${plan.createdAt.day}.${plan.createdAt.month}.${plan.createdAt.year}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDisplayMode({
    required String? decryptedComment,
    required String? decryptedStrengths,
    required String? decryptedProblems,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (plan.socialPedagogue?.isNotEmpty ?? false) ...[
          const Gap(8),
          const Text(
            'Sozialpädagoge:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const Gap(2),
          Text(plan.socialPedagogue!, style: const TextStyle(fontSize: 12)),
        ],
        if (plan.specialNeedsTeacher?.isNotEmpty ?? false) ...[
          const Gap(8),
          const Text(
            'Sonderpädagog*in:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const Gap(2),
          Text(plan.specialNeedsTeacher!, style: const TextStyle(fontSize: 12)),
        ],

        if (plan.proffesionalsInvolved?.isNotEmpty ?? false) ...[
          const Gap(8),
          const Text(
            'Beteiligte Fachkräfte:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const Gap(2),
          Text(
            plan.proffesionalsInvolved!,
            style: const TextStyle(fontSize: 12),
          ),
        ],
        if (decryptedStrengths?.isNotEmpty ?? false) ...[
          const Gap(8),
          const Text(
            'Stärken:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const Gap(2),
          Text(decryptedStrengths!, style: const TextStyle(fontSize: 12)),
        ],
        if (decryptedProblems?.isNotEmpty ?? false) ...[
          const Gap(8),
          const Text(
            'Probleme:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const Gap(2),
          Text(decryptedProblems!, style: const TextStyle(fontSize: 12)),
        ],
        if (decryptedComment?.isNotEmpty ?? false) ...[
          const Gap(8),
          const Text(
            'Ergänzende Hinweise und Absprachen:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const Gap(2),
          Text(decryptedComment!, style: const TextStyle(fontSize: 12)),
        ],
      ],
    );
  }
}
