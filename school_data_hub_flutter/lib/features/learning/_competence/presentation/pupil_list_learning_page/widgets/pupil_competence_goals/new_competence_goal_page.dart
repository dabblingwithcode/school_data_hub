import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_manager.dart';

/// A full-screen page for creating or editing a [CompetenceGoal].
///
/// **Create mode**: pass [pupilId] and [competenceId], leave [existingGoal]
/// null.
/// **Edit mode**: pass [existingGoal] (pupilId / competenceId are taken from
/// the goal).
class NewCompetenceGoalScreen extends StatefulWidget {
  /// Required when creating a new goal. Ignored in edit mode.
  final int? pupilId;

  /// Required when creating a new goal. Ignored in edit mode.
  final int? competenceId;

  /// When non-null the page opens in edit mode.
  final CompetenceGoal? existingGoal;

  const NewCompetenceGoalScreen({
    this.pupilId,
    this.competenceId,
    this.existingGoal,
    super.key,
  }) : assert(
         existingGoal != null || (pupilId != null && competenceId != null),
         'Either existingGoal or both pupilId and competenceId must be provided',
       );

  @override
  State<NewCompetenceGoalScreen> createState() => _NewCompetenceGoalScreenState();
}

class _NewCompetenceGoalScreenState extends State<NewCompetenceGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _strategiesController = TextEditingController();

  late final bool _isEditMode;
  late final Competence? _competence;
  final List<String> _strategies = [];
  DateTime? _achievedAt;

  bool get _isAchieved => _achievedAt != null;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.existingGoal != null;

    final competenceId = _isEditMode
        ? widget.existingGoal!.competenceId
        : widget.competenceId!;

    _competence = di<CompetenceManager>().findCompetenceById(competenceId);

    if (_isEditMode) {
      _descriptionController.text = widget.existingGoal!.description;
      _strategies.addAll(widget.existingGoal!.strategies ?? []);
      final existingDate = widget.existingGoal!.achievedAt;
      _achievedAt = existingDate;
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _strategiesController.dispose();
    super.dispose();
  }

  void _addStrategy() {
    if (_strategiesController.text.isNotEmpty) {
      setState(() {
        _strategies.add(_strategiesController.text);
        _strategiesController.clear();
      });
    }
  }

  void _removeStrategy(int index) {
    setState(() {
      _strategies.removeAt(index);
    });
  }

  Future<void> _save() async {
    final competence = _competence;
    if (!_formKey.currentState!.validate() || competence == null) return;

    if (_isEditMode) {
      await di<CompetenceManager>().updateCompetenceGoal(
        publicId: widget.existingGoal!.publicId,
        description: (value: _descriptionController.text),
        strategies: (value: _strategies),
        achievedAt: (value: _achievedAt),
      );
    } else {
      await di<CompetenceManager>().postCompetenceGoal(
        pupilId: widget.pupilId!,
        competenceId: competence.publicId,
        description: _descriptionController.text,
        strategies: _strategies,
      );
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final competence = _competence;
    if (competence == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Fehler')),
        body: const Center(
          child: Text('Kompetenz konnte nicht gefunden werden.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppHeader(
        iconData: Icons.emoji_nature_rounded,
        title: _isEditMode ? 'Lernziel bearbeiten' : 'Neues Lernziel',
      ),
      body: Padding(
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Ausgewählte Kompetenz:',
                style: context.typography.subtitle.bold,
              ),
              Gap(Style.spacing.xs),
              Container(
                padding: EdgeInsets.all(Style.spacing.md),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Style.radii.small),
                  color: style.colors.cardInCard,
                ),
                child: Text(
                  competence.name,
                  style: context.typography.subtitle,
                ),
              ),
              Gap(Style.spacing.xl),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Zielbeschreibung',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty
                    ? 'Bitte eine Beschreibung eingeben'
                    : null,
                maxLines: 3,
              ),
              Gap(Style.spacing.xl),
              Text(
                'Strategien:',
                style: context.typography.subtitle.bold,
              ),
              Gap(Style.spacing.sm),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _strategiesController,
                      decoration: const InputDecoration(
                        labelText: 'Strategie hinzufügen',
                        border: OutlineInputBorder(),
                      ),
                      onFieldSubmitted: (_) => _addStrategy(),
                    ),
                  ),
                  Gap(Style.spacing.sm),
                  IconButton(
                    icon: const Icon(Icons.add_circle, size: 32),
                    onPressed: _addStrategy,
                  ),
                ],
              ),
              Gap(Style.spacing.md),
              if (_strategies.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: style.colors.mutedForeground),
                    borderRadius: BorderRadius.circular(Style.radii.small),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _strategies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text(
                          '${index + 1}.',
                          style: context.typography.body.bold,
                        ),
                        title: Text(_strategies[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: style.colors.error),
                          onPressed: () => _removeStrategy(index),
                        ),
                        dense: true,
                      );
                    },
                  ),
                ),
              if (_isEditMode) ...[
                Gap(Style.spacing.xl),
                Text(
                  'Erreicht am:',
                  style: context.typography.subtitle.bold,
                ),
                Gap(Style.spacing.sm),
                GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _achievedAt ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setState(() {
                        _achievedAt = picked;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Style.spacing.md,
                      horizontal: Style.spacing.lg,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _isAchieved
                            ? style.colors.success
                            : style.colors.mutedForeground,
                      ),
                      borderRadius: BorderRadius.circular(Style.radii.small),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isAchieved
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: _isAchieved ? style.colors.success : style.colors.mutedForeground,
                        ),
                        Gap(Style.spacing.md),
                        Text(
                          _isAchieved
                              ? _achievedAt!.formatDateForUser()
                              : 'Nicht erreicht - Tippen zum Setzen',
                          style: context.typography.subtitle.bold.withColor(
                            _isAchieved
                                ? style.colors.success
                                : style.colors.interactive,
                          ),
                        ),
                        const Spacer(),
                        if (_isAchieved)
                          IconButton(
                            icon: Icon(Icons.clear, color: style.colors.error),
                            tooltip: 'Datum entfernen',
                            onPressed: () {
                              setState(() {
                                _achievedAt = null;
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ],
              const Gap(40),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      label: _isEditMode ? 'SPEICHERN' : 'LERNZIEL ERSTELLEN',
                      onPressed: _save,
                    ),
                  ),
                ],
              ),
              Gap(Style.spacing.md),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      variant: ButtonVariant.secondary,
                      label: 'ABBRECHEN',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Keep the old name as a typedef for backward compatibility.
typedef NewCompetenceGoalPage = NewCompetenceGoalScreen;
