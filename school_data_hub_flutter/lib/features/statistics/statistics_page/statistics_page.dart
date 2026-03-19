import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/controller/statistics.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/list_tiles/enrollment_list_tiles.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/list_tiles/group_list_tiles.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/list_tiles/languages_list_tiles.dart';

class StatisticsScreen extends StatelessWidget {
  final StatisticsController controller;
  const StatisticsScreen(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: style.colors.canvas,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: style.colors.accent,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart_rounded, size: 25, color: style.colors.accentForeground),
              const Gap(10),
              Text(
                'Statistik',
                style: TextStyle(
                  color: style.colors.accentForeground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: style.colors.accentForeground,
            unselectedLabelColor: style.colors.accentForeground.withValues(alpha: 0.7),
            indicatorColor: style.colors.accentForeground,
            tabs: const [
              Tab(text: 'Schulzahlen'),
              Tab(text: 'Sprachen'),
              Tab(text: 'Unterjährige Anmeldungen'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _StatisticsTabContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(15),
                  GroupListTiles(controller: controller),
                ],
              ),
            ),
            _StatisticsTabContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(15),
                  LanguagesListTiles(controller: controller),
                ],
              ),
            ),
            _StatisticsTabContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(15),
                  EnrollmentListTiles(controller: controller),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.all(10),
          shape: null,
          color: style.colors.accent,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'zurück',
                    icon: const Icon(Icons.arrow_back, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatisticsTabContainer extends StatelessWidget {
  final Widget child;
  const _StatisticsTabContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 20),
          child: SingleChildScrollView(child: child),
        ),
      ),
    );
  }
}
