import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/learning/domain/filters/competence_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/competence_list_page/widgets/competence_filters_widget.dart';
import 'package:watch_it/watch_it.dart';

final _competenceFilterManager = di<CompetenceFilterManager>();

class CompetenceListPageBottomNavBar extends StatelessWidget {
  final List<Competence> competences;
  const CompetenceListPageBottomNavBar({required this.competences, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(10),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: [
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(30),
              IconButton(
                tooltip: 'Reihenfolge ändern',
                icon: const Icon(Icons.sort_rounded),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (ctx) => const CompetenceListSortablePage(),
                  // ));
                },
              ),
              const Gap(30),
              IconButton(
                tooltip: 'aktualisieren',
                icon: const Icon(Icons.update_rounded),
                onPressed: () {
                  _competenceFilterManager
                      .refreshFilteredCompetences(competences);
                },
              ),
              const Gap(30),
              IconButton(
                tooltip: 'Filter',
                icon: const Icon(Icons.filter_list_rounded),
                onPressed: () => showGenericFilterBottomSheet(
                    context: context, filterList: [const CompetenceFilters()]),
              ),
              const Gap(10)
            ],
          ),
        ),
      ),
    );
  }
}
