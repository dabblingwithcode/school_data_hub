import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/learning_support_plan_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

/// A card widget for displaying and editing a learning support plan.
///
/// Shows plan details in display mode with an edit button that switches
/// to inline editing of the plan's text fields. Changes are saved to the
/// server via [LearningSupportManager].
class LearningSupportPlanCard extends StatefulWidget {
  final LearningSupportPlan plan;
  final PupilProxy pupil;

  const LearningSupportPlanCard({
    required this.plan,
    required this.pupil,
    super.key,
  });

  @override
  State<LearningSupportPlanCard> createState() =>
      _LearningSupportPlanCardState();
}

class _LearningSupportPlanCardState extends State<LearningSupportPlanCard> {
  bool _isEditing = false;
  bool _isSaving = false;

  late final TextEditingController _commentController;
  late final TextEditingController _socialPedagogueController;
  late final TextEditingController _professionalsInvolvedController;
  late final TextEditingController _strengthsDescriptionController;
  late final TextEditingController _problemsDescriptionController;

  LearningSupportPlan get plan => widget.plan;
  PupilProxy get pupil => widget.pupil;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _commentController = TextEditingController(text: plan.comment ?? '');
    _socialPedagogueController = TextEditingController(
      text: plan.socialPedagogue ?? '',
    );
    _professionalsInvolvedController = TextEditingController(
      text: plan.proffesionalsInvolved ?? '',
    );
    _strengthsDescriptionController = TextEditingController(
      text: plan.strengthsDescription ?? '',
    );
    _problemsDescriptionController = TextEditingController(
      text: plan.problemsDescription ?? '',
    );
  }

  @override
  void didUpdateWidget(LearningSupportPlanCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.plan != widget.plan && !_isEditing) {
      _commentController.text = plan.comment ?? '';
      _socialPedagogueController.text = plan.socialPedagogue ?? '';
      _professionalsInvolvedController.text = plan.proffesionalsInvolved ?? '';
      _strengthsDescriptionController.text = plan.strengthsDescription ?? '';
      _problemsDescriptionController.text = plan.problemsDescription ?? '';
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    _socialPedagogueController.dispose();
    _professionalsInvolvedController.dispose();
    _strengthsDescriptionController.dispose();
    _problemsDescriptionController.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      _commentController.text = plan.comment ?? '';
      _socialPedagogueController.text = plan.socialPedagogue ?? '';
      _professionalsInvolvedController.text = plan.proffesionalsInvolved ?? '';
      _strengthsDescriptionController.text = plan.strengthsDescription ?? '';
      _problemsDescriptionController.text = plan.problemsDescription ?? '';
      _isEditing = true;
    });
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
    });
  }

  Future<void> _saveChanges() async {
    setState(() => _isSaving = true);

    final updatedPlan = plan.copyWith(
      comment: _commentController.text.trim().isEmpty
          ? null
          : _commentController.text.trim(),
      socialPedagogue: _socialPedagogueController.text.trim().isEmpty
          ? null
          : _socialPedagogueController.text.trim(),
      proffesionalsInvolved:
          _professionalsInvolvedController.text.trim().isEmpty
          ? null
          : _professionalsInvolvedController.text.trim(),
      strengthsDescription: _strengthsDescriptionController.text.trim().isEmpty
          ? null
          : _strengthsDescriptionController.text.trim(),
      problemsDescription: _problemsDescriptionController.text.trim().isEmpty
          ? null
          : _problemsDescriptionController.text.trim(),
    );

    final success = await di<LearningSupportManager>()
        .updateLearningSupportPlan(plan: updatedPlan);

    if (mounted) {
      setState(() {
        _isSaving = false;
        if (success) {
          _isEditing = false;
        }
      });
    }
  }

  Future<void> _generatePlanPdf() async {
    try {
      final supportCategoryManager = di<SupportCategoryManager>();
      final supportCategories = supportCategoryManager.supportCategories.value;

      final file =
          await LearningSupportPlanPdfGenerator.generateLearningSupportPlanPdf(
            plan: plan,
            pupil: pupil,
            supportCategories: supportCategories,
          );

      if (mounted) {
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Plan ID, Support Level, action buttons
            _buildHeader(),
            const Gap(8),

            // Created info
            _buildCreatedInfo(),

            // Content: either display or edit mode
            if (_isEditing) _buildEditMode() else _buildDisplayMode(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Förderplan Nr. ${plan.planId}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        const Gap(10),
        // Edit Button
        InkWell(
          onTap: _isEditing ? null : _startEditing,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _isEditing
                  ? Colors.grey.withValues(alpha: 0.1)
                  : AppColors.interactiveColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: _isEditing
                    ? Colors.grey.withValues(alpha: 0.3)
                    : AppColors.interactiveColor.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              Icons.edit,
              size: 20,
              color: _isEditing ? Colors.grey : AppColors.interactiveColor,
            ),
          ),
        ),
        const Gap(6),
        // PDF Generation Button
        InkWell(
          onTap: _generatePlanPdf,
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

  Widget _buildDisplayMode() {
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
        if (plan.strengthsDescription?.isNotEmpty ?? false) ...[
          const Gap(8),
          const Text(
            'Stärken:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const Gap(2),
          Text(
            plan.strengthsDescription!,
            style: const TextStyle(fontSize: 12),
          ),
        ],
        if (plan.problemsDescription?.isNotEmpty ?? false) ...[
          const Gap(8),
          const Text(
            'Probleme:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const Gap(2),
          Text(plan.problemsDescription!, style: const TextStyle(fontSize: 12)),
        ],
        if (plan.comment?.isNotEmpty ?? false) ...[
          const Gap(8),
          const Text(
            'Ergänzende Hinweise und Absprachen:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const Gap(2),
          Text(plan.comment!, style: const TextStyle(fontSize: 12)),
        ],
      ],
    );
  }

  Widget _buildEditMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(12),
        const Divider(),
        const Gap(8),

        // Comment field
        const Text(
          'Ergänze Hinweise und Absprachen:',
          style: AppStyles.textLabel,
        ),
        const Gap(4),
        TextField(
          controller: _commentController,
          maxLines: 3,
          decoration: AppStyles.textFieldDecoration(labelText: 'Kommentar'),
        ),

        const Gap(12),

        // Social Pedagogue field
        const Text('Sozialpädagoge:', style: AppStyles.textLabel),
        const Gap(4),
        TextField(
          controller: _socialPedagogueController,
          decoration: AppStyles.textFieldDecoration(
            labelText: 'Sozialpädagoge',
          ),
        ),

        const Gap(12),

        // Professionals Involved field
        const Text('Beteiligte Fachkräfte:', style: AppStyles.textLabel),
        const Gap(4),
        TextField(
          controller: _professionalsInvolvedController,
          maxLines: 3,
          decoration: AppStyles.textFieldDecoration(
            labelText: 'Beteiligte Fachkräfte',
          ),
        ),

        const Gap(12),

        // Strengths Description field
        const Text('Stärken:', style: AppStyles.textLabel),
        const Gap(4),
        TextField(
          controller: _strengthsDescriptionController,
          maxLines: 4,
          decoration: AppStyles.textFieldDecoration(
            labelText: 'Stärkenbeschreibung',
          ),
        ),

        const Gap(12),

        // Problems Description field
        const Text('Probleme:', style: AppStyles.textLabel),
        const Gap(4),
        TextField(
          controller: _problemsDescriptionController,
          maxLines: 4,
          decoration: AppStyles.textFieldDecoration(
            labelText: 'Problembeschreibung',
          ),
        ),

        const Gap(16),

        // Save / Cancel buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: AppStyles.cancelButtonStyle,
                onPressed: _isSaving ? null : _cancelEditing,
                child: const Text(
                  'ABBRECHEN',
                  style: AppStyles.buttonTextStyle,
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: ElevatedButton(
                style: AppStyles.actionButtonStyle,
                onPressed: _isSaving ? null : _saveChanges,
                child: _isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('SPEICHERN', style: AppStyles.buttonTextStyle),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
