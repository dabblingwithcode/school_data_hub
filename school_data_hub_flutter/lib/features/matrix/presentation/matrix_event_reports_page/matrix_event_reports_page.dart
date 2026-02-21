import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/bottom_nav_bar/generic_bottom_nav_bar_no_filter.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_event_report.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/matrix_event_reports_page/widgets/matrix_event_report_detail_sheet.dart';

class MatrixEventReportsPage extends StatefulWidget {
  const MatrixEventReportsPage({super.key});

  @override
  State<MatrixEventReportsPage> createState() => _MatrixEventReportsPageState();
}

class _MatrixEventReportsPageState extends State<MatrixEventReportsPage> {
  final ScrollController _scrollController = ScrollController();

  MatrixPolicyManager get _matrixPolicyManager => di<MatrixPolicyManager>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_matrixPolicyManager.eventReports.value.isEmpty) {
        _matrixPolicyManager.refreshEventReports();
      }
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final thresholdReached =
        _scrollController.position.pixels >=
        (_scrollController.position.maxScrollExtent - 250);
    if (!thresholdReached) {
      return;
    }

    _matrixPolicyManager.loadMoreEventReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.flag_circle_rounded,
        title: 'Event Reports',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: RefreshIndicator(
            onRefresh: () => _matrixPolicyManager.refreshEventReports(),
            child: ValueListenableBuilder<List<MatrixEventReport>>(
              valueListenable: _matrixPolicyManager.eventReports,
              builder: (context, reports, _) {
                return ValueListenableBuilder<bool>(
                  valueListenable: _matrixPolicyManager.eventReportsLoading,
                  builder: (context, isLoading, _) {
                    return ValueListenableBuilder<bool>(
                      valueListenable:
                          _matrixPolicyManager.eventReportsLoadingMore,
                      builder: (context, isLoadingMore, _) {
                        return ValueListenableBuilder<int>(
                          valueListenable:
                              _matrixPolicyManager.eventReportsTotal,
                          builder: (context, total, _) {
                            return ValueListenableBuilder<String?>(
                              valueListenable:
                                  _matrixPolicyManager.eventReportsError,
                              builder: (context, errorMessage, _) {
                                if (isLoading && reports.isEmpty) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (reports.isEmpty) {
                                  return ListView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    children: [
                                      const Gap(120),
                                      Icon(
                                        Icons.flag_outlined,
                                        size: 48,
                                        color: Colors.grey[500],
                                      ),
                                      const Gap(12),
                                      const Center(
                                        child: Text(
                                          'Keine Event Reports gefunden',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      if (errorMessage != null) ...[
                                        const Gap(12),
                                        Center(
                                          child: Text(
                                            errorMessage,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  );
                                }

                                return ListView.separated(
                                  controller: _scrollController,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(12),
                                  itemCount: reports.length + 2,
                                  separatorBuilder: (_, __) => const Gap(8),
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Row(
                                        children: [
                                          Text(
                                            'Gesamt: $total',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            tooltip: 'Neu laden',
                                            onPressed: () =>
                                                _matrixPolicyManager
                                                    .refreshEventReports(),
                                            icon: const Icon(Icons.refresh),
                                          ),
                                        ],
                                      );
                                    }

                                    if (index == reports.length + 1) {
                                      if (isLoadingMore) {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 20,
                                          ),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }
                                      return const SizedBox(height: 8);
                                    }

                                    final report = reports[index - 1];

                                    return Card(
                                      color: AppColors.backgroundColor,
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                        title: Text(
                                          report.name ?? report.roomId,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 6,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _mxIdLine(
                                                context: context,
                                                label: 'Meldender',
                                                mxId: report.userId,
                                              ),
                                              const Gap(2),
                                              _mxIdLine(
                                                context: context,
                                                label: 'Sender',
                                                mxId: report.sender,
                                              ),
                                              const Gap(2),
                                              Text(
                                                'Zeit: ${_formatTimestamp(report.receivedTs)}',
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: () => showModalBottomSheet<void>(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (_) =>
                                              MatrixEventReportDetailSheet(
                                                reportId: report.id,
                                              ),
                                        ),
                                        trailing: IconButton(
                                          tooltip: 'Report löschen',
                                          icon: const Icon(
                                            Icons.delete_rounded,
                                            color: Colors.redAccent,
                                          ),
                                          onPressed: () async {
                                            final delete = await showDialog<bool>(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                title: const Text(
                                                  'Event Report löschen?',
                                                ),
                                                content: Text(
                                                  'Report-ID ${report.id} wird gelöscht.',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                          context,
                                                          false,
                                                        ),
                                                    child: const Text(
                                                      'Abbrechen',
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                          context,
                                                          true,
                                                        ),
                                                    child: const Text(
                                                      'Löschen',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );

                                            if (delete == true) {
                                              await _matrixPolicyManager
                                                  .deleteEventReport(report.id);
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: const GenericBottomNavBarNoFilter(),
    );
  }

  String _formatTimestamp(int timestamp) {
    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
    final mm = dt.month.toString().padLeft(2, '0');
    final dd = dt.day.toString().padLeft(2, '0');
    final hh = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$dd.$mm.${dt.year} $hh:$min';
  }

  Widget _mxIdLine({
    required BuildContext context,
    required String label,
    required String mxId,
  }) {
    final resolvedName = _resolveMxIdToName(mxId);

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        Text('$label:', style: const TextStyle(color: Colors.white70)),
        InkWell(
          onTap: () => MatrixPolicyHelper.launchMatrixUrl(context, mxId),
          child: Tooltip(
            message: mxId,
            child: Text(
              resolvedName,
              style: const TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _resolveMxIdToName(String mxId) {
    final knownUsers = _matrixPolicyManager.matrixUsers.value;
    for (final matrixUser in knownUsers) {
      if (matrixUser.id == mxId && matrixUser.displayName.isNotEmpty) {
        return matrixUser.displayName;
      }
    }

    var localPart = mxId;
    if (localPart.startsWith('@')) {
      localPart = localPart.substring(1);
    }
    if (localPart.contains(':')) {
      localPart = localPart.split(':').first;
    }
    return localPart;
  }
}
