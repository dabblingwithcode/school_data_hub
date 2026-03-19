import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/auth/auth_clearance_helper.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan_screen/controller/new_learning_support_plan_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/learning_support_plan_pdf_generator.dart';

/// A display-only card for a learning support plan.
///
/// Shows plan details and provides an edit button that navigates to the
/// [NewLearningSupportPlan] page in edit mode, and a PDF generation button.
/// Encrypted fields (comment, strengthsDescription, problemsDescription)
/// are decrypted once at build time.
class LearningSupportPlanCard extends WatchingWidget {
  final LearningSupportPlan plan;
  final PupilProxy pupil;

  const LearningSupportPlanCard({
    required this.plan,
    required this.pupil,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(() => ExpansionController());

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Style.spacing.xs,
        vertical: 4.0,
      ),
      child: CardBox(
        variant: CardBoxVariant.filledSecondary,
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PlanHeader(plan: plan),
            Gap(Style.spacing.sm),
            _PlanMetadataAndActions(
              plan: plan,
              pupil: pupil,
              tileController: tileController,
            ),
            ExpansionBody(
              tileController: tileController,
              widgetList: [_PlanDetails(plan: plan)],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanHeader extends StatelessWidget {
  final LearningSupportPlan plan;

  const _PlanHeader({required this.plan});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            'Förderplan Nr. ${plan.number}',
            style: context.typography.title,
          ),
        ),
        const Spacer(),
        Icon(
          Icons.calendar_today,
          size: 16,
          color: style.colors.mutedForeground,
        ),
        Gap(Style.spacing.xs),
        Text(
          '${plan.createdAt.day}.${plan.createdAt.month}.${plan.createdAt.year}',
          style: context.typography.subtitle.bold,
        ),
      ],
    );
  }
}

class _PlanMetadataAndActions extends StatelessWidget {
  final LearningSupportPlan plan;
  final PupilProxy pupil;
  final ExpansionController tileController;

  const _PlanMetadataAndActions({
    required this.plan,
    required this.pupil,
    required this.tileController,
  });

  void _editPlan(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) =>
            NewLearningSupportPlan(pupil: pupil, existingPlan: plan),
      ),
    );
  }

  Future<void> _generatePlanPdf(BuildContext context) async {
    try {
      final supportCategoryManager = di<SupportCategoryManager>();
      final supportCategories = supportCategoryManager.supportCategories.value;

      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (ctx) => PdfViewerScreen(
              pdfGenerator: () =>
                  LearningSupportPlanPdfGenerator.generateLearningSupportPlanPdf(
                    plan: plan,
                    pupil: pupil,
                    supportCategories: supportCategories,
                  ),
              title: 'Förderplan PDF',
            ),
          ),
        );
      }
    } catch (e) {
      di<NotificationManager>().showSnackBar(
        NotificationType.error,
        'Fehler beim Erstellen des PDFs: $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Row(
      children: [
        Icon(Icons.person, size: 16, color: style.colors.mutedForeground),
        Gap(Style.spacing.xs),
        Text(
          'Erstellt von: ${plan.createdBy}',
          style: context.typography.bodySmall.withColor(
            style.colors.mutedForeground,
          ),
        ),
        const Spacer(),
        if (AuthClearanceHelper.isTutorOrAdmin(pupil)) ...[
          _EditButton(onTap: () => _editPlan(context)),
          const Gap(6),
        ],
        _PdfButton(onTap: () => _generatePlanPdf(context)),
        const Gap(6),
        ExpansionHeader(
          expansionController: tileController,
          switchColor: style.colors.interactive,
        ),
      ],
    );
  }
}

class _EditButton extends StatelessWidget {
  final VoidCallback onTap;

  const _EditButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Style.spacing.sm),
        decoration: BoxDecoration(
          color: style.colors.interactive.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(Style.radii.small),
          border: Border.all(
            color: style.colors.interactive.withValues(alpha: 0.3),
          ),
        ),
        child: Icon(Icons.edit, size: 20, color: style.colors.interactive),
      ),
    );
  }
}

class _PdfButton extends StatelessWidget {
  final VoidCallback onTap;

  const _PdfButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Style.spacing.sm),
        decoration: BoxDecoration(
          color: style.colors.accent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(Style.radii.small),
          border: Border.all(color: style.colors.accent.withValues(alpha: 0.3)),
        ),
        child: Icon(Icons.picture_as_pdf, size: 20, color: style.colors.accent),
      ),
    );
  }
}

class _PlanDetails extends StatelessWidget {
  final LearningSupportPlan plan;

  const _PlanDetails({required this.plan});

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

    return Padding(
      padding: EdgeInsets.only(top: Style.spacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (plan.socialPedagogue?.isNotEmpty ?? false)
            _PlanDetailField(
              label: 'Sozialpädagoge:',
              value: plan.socialPedagogue!,
            ),
          if (plan.specialNeedsTeacher?.isNotEmpty ?? false)
            _PlanDetailField(
              label: 'Sonderpädagog*in:',
              value: plan.specialNeedsTeacher!,
            ),
          if (plan.proffesionalsInvolved?.isNotEmpty ?? false)
            _PlanDetailField(
              label: 'Beteiligte Fachkräfte:',
              value: plan.proffesionalsInvolved!,
            ),
          if (decryptedStrengths?.isNotEmpty ?? false)
            _PlanDetailField(label: 'Stärken:', value: decryptedStrengths!),
          if (decryptedProblems?.isNotEmpty ?? false)
            _PlanDetailField(label: 'Probleme:', value: decryptedProblems!),
          if (decryptedComment?.isNotEmpty ?? false)
            _PlanDetailField(
              label: 'Ergänzende Hinweise und Absprachen:',
              value: decryptedComment!,
            ),
        ],
      ),
    );
  }
}

class _PlanDetailField extends StatelessWidget {
  final String label;
  final String value;

  const _PlanDetailField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Style.spacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: context.typography.bodySmall.w500),
          const Gap(2),
          Text(value, style: context.typography.bodySmall),
        ],
      ),
    );
  }
}
