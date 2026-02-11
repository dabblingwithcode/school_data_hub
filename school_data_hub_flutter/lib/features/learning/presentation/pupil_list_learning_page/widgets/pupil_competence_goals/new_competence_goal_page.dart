import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';

/// A full-screen page for creating or editing a [CompetenceGoal].
///
/// **Create mode**: pass [pupilId] and [competenceId], leave [existingGoal]
/// null.
/// **Edit mode**: pass [existingGoal] (pupilId / competenceId are taken from
/// the goal).
class NewCompetenceGoalPage extends StatefulWidget {
  /// Required when creating a new goal. Ignored in edit mode.
  final int? pupilId;

  /// Required when creating a new goal. Ignored in edit mode.
  final int? competenceId;

  /// When non-null the page opens in edit mode.
  final CompetenceGoal? existingGoal;

  const NewCompetenceGoalPage({
    this.pupilId,
    this.competenceId,
    this.existingGoal,
    super.key,
  }) : assert(
         existingGoal != null || (pupilId != null && competenceId != null),
         'Either existingGoal or both pupilId and competenceId must be provided',
       );

  @override
  State<NewCompetenceGoalPage> createState() => _NewCompetenceGoalPageState();
}

class _NewCompetenceGoalPageState extends State<NewCompetenceGoalPage> {
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
      appBar: GenericAppBar(
        iconData: Icons.emoji_nature_rounded,
        title: _isEditMode ? 'Lernziel bearbeiten' : 'Neues Lernziel',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Ausgewählte Kompetenz:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Gap(5),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.cardInCardColor,
                ),
                child: Text(
                  competence.name,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const Gap(20),
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
              const Gap(20),
              const Text(
                'Strategien:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Gap(8),
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
                  const Gap(8),
                  IconButton(
                    icon: const Icon(Icons.add_circle, size: 32),
                    onPressed: _addStrategy,
                  ),
                ],
              ),
              const Gap(10),
              if (_strategies.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _strategies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text(
                          '${index + 1}.',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        title: Text(_strategies[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeStrategy(index),
                        ),
                        dense: true,
                      );
                    },
                  ),
                ),
              if (_isEditMode) ...[
                const Gap(20),
                const Text(
                  'Erreicht am:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Gap(8),
                InkWell(
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
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _isAchieved
                            ? Colors.green
                            : Colors.grey.shade400,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isAchieved
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: _isAchieved ? Colors.green : Colors.grey,
                        ),
                        const Gap(12),
                        Text(
                          _isAchieved
                              ? _achievedAt!.formatDateForUser()
                              : 'Nicht erreicht - Tippen zum Setzen',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _isAchieved
                                ? Colors.green
                                : AppColors.interactiveColor,
                          ),
                        ),
                        const Spacer(),
                        if (_isAchieved)
                          IconButton(
                            icon: const Icon(Icons.clear, color: Colors.red),
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
                    child: ElevatedButton(
                      style: AppStyles.successButtonStyle,
                      onPressed: _save,
                      child: Text(
                        _isEditMode ? 'SPEICHERN' : 'LERNZIEL ERSTELLEN',
                        style: AppStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: AppStyles.cancelButtonStyle,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'ABBRECHEN',
                        style: AppStyles.buttonTextStyle,
                      ),
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
