import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:watch_it/watch_it.dart';

class AddCompetenceGoalDialog extends WatchingStatefulWidget {
  final int pupilId;
  final int competenceId;
  const AddCompetenceGoalDialog({
    required this.pupilId,
    required this.competenceId,
    super.key,
  });

  @override
  State<AddCompetenceGoalDialog> createState() =>
      _AddCompetenceGoalDialogState();
}

class _AddCompetenceGoalDialogState extends State<AddCompetenceGoalDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _strategiesController = TextEditingController();

  Competence? _competence;
  List<String> _strategies = [];

  @override
  void initState() {
    super.initState();
    _competence = di<CompetenceManager>().findCompetenceById(
      widget.competenceId,
    );
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

  @override
  Widget build(BuildContext context) {
    if (_competence == null) {
      return const AlertDialog(
        title: Text('Fehler'),
        content: Text('Kompetenz konnte nicht gefunden werden.'),
      );
    }

    return AlertDialog(
      title: const Text('Neues Lernziel'),
      content: SizedBox(
        width: 600,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ausgewählte Kompetenz:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Gap(5),
                Text(_competence!.name, style: const TextStyle(fontSize: 16)),
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
                const Gap(15),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _strategiesController,
                        decoration: const InputDecoration(
                          labelText: 'Strategie hinzufügen',
                        ),
                        onFieldSubmitted: (_) => _addStrategy(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      onPressed: _addStrategy,
                    ),
                  ],
                ),
                const Gap(10),
                if (_strategies.isNotEmpty)
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _strategies.length,
                      itemBuilder: (context, index) {
                        return ListTile(
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
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbrechen'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate() && _competence != null) {
              await di<CompetenceManager>().postCompetenceGoal(
                pupilId: widget.pupilId,
                competenceId: _competence!.publicId,
                description: _descriptionController.text,
                strategies: _strategies,
              );
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          },
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}
