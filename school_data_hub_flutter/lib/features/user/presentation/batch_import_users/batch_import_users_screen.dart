import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:printing/printing.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/spinner.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/user/data/staff_excel_import_parser.dart';
import 'package:school_data_hub_flutter/features/user/domain/batch_create_result.dart';
import 'package:school_data_hub_flutter/features/user/domain/staff_import_row.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/batch_import_users/staff_credentials_pdf_service.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

final _log = Logger('BatchImportUsersScreen');

class BatchImportUsersScreen extends StatefulWidget {
  const BatchImportUsersScreen({super.key});

  @override
  State<BatchImportUsersScreen> createState() => _BatchImportUsersScreenState();
}

class _BatchImportUsersScreenState extends State<BatchImportUsersScreen> {
  StaffImportParseResult? _parseResult;
  BatchCreateResult? _batchResult;
  bool _isCreating = false;
  int _progressCreated = 0;
  int _progressErrors = 0;
  StreamSubscription<BatchCreateResult>? _chunkSubscription;

  // Per-row live status tracked during streaming.
  final _successEmails = <String>{};
  final _errorByKurzel = <String, String>{};

  @override
  void dispose() {
    _chunkSubscription?.cancel();
    WakelockPlus.disable();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await StaffExcelImportParser.pickAndParse();
    if (result != null && mounted) {
      setState(() {
        _parseResult = result;
        _batchResult = null;
        _successEmails.clear();
        _errorByKurzel.clear();
      });
    }
  }

  Future<void> _createUsers() async {
    final rows = _parseResult?.rows ?? [];
    _log.info('[BatchImport] Benutzer anlegen clicked, rows=${rows.length}');
    if (rows.isEmpty) {
      _log.warning('[BatchImport] No rows to create, returning');
      return;
    }
    setState(() {
      _isCreating = true;
      _batchResult = null;
      _progressCreated = 0;
      _progressErrors = 0;
      _successEmails.clear();
      _errorByKurzel.clear();
    });

    await WakelockPlus.enable();
    _log.info('[BatchImport] Wakelock enabled');

    final userManager = di<UserManager>();
    final allCredentials = <StaffCredentialEntry>[];
    final allErrors = <BatchCreateError>[];

    try {
      final stream = userManager.batchCreateUsersViaStream(rows);
      _log.info('[BatchImport] Subscribing to batchCreateUsersViaStream');
      _chunkSubscription = stream.listen(
        (chunkResult) {
          if (!mounted) return;
          allCredentials.addAll(chunkResult.credentials);
          allErrors.addAll(chunkResult.errors);
          _safeSetState(() {
            _progressCreated = allCredentials.length;
            _progressErrors = allErrors.length;
            for (final c in chunkResult.credentials) {
              _successEmails.add(c.email);
            }
            for (final e in chunkResult.errors) {
              _errorByKurzel[e.userNameOrKurzel] = e.message;
            }
          });
          _log.info(
            '[BatchImport] Chunk done — created=${chunkResult.successCount}, '
            'errors=${chunkResult.failureCount}, '
            'total created=${allCredentials.length}, total errors=${allErrors.length}',
          );
        },
        onError: (Object e, StackTrace? st) {
          _log.severe('[BatchImport] Chunk stream onError', e, st);
          WakelockPlus.disable();
          if (mounted) {
            _safeSetState(() => _isCreating = false);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Fehler: $e')));
          }
        },
        onDone: () {
          _log.info(
            '[BatchImport] All chunks done — '
            'credentials=${allCredentials.length} errors=${allErrors.length}',
          );
          WakelockPlus.disable();
          if (!mounted) return;
          _safeSetState(() {
            _batchResult = BatchCreateResult(
              credentials: allCredentials,
              errors: allErrors,
            );
            _isCreating = false;
            _progressCreated = 0;
            _progressErrors = 0;
          });
        },
        cancelOnError: false,
      );
    } catch (e, st) {
      _log.severe('[BatchImport] _createUsers catch', e, st);
      await WakelockPlus.disable();
      if (mounted) {
        setState(() => _isCreating = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Fehler: $e')));
      }
    }
  }

  Widget _buildStatusCell(StaffImportRow row) {
    final style = Style.of(context);
    if (_successEmails.contains(row.email)) {
      return Icon(Icons.check_circle, color: style.colors.success, size: 18);
    }
    final errorMsg = _errorByKurzel[row.kurzel];
    if (errorMsg != null) {
      return Tooltip(
        message: errorMsg,
        child: Icon(Icons.error, color: style.colors.error, size: 18),
      );
    }
    if (_isCreating) {
      return SizedBox(
        width: 16,
        height: 16,
        child: Spinner(color: style.colors.foreground),
      );
    }
    return const SizedBox.shrink();
  }

  /// Schedules [setState] for the next frame to avoid calling it during layout.
  void _safeSetState(VoidCallback fn) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(fn);
    });
  }

  void _abortCreate() {
    _log.info('[BatchImport] User aborted batch create');
    _chunkSubscription?.cancel();
    _chunkSubscription = null;
    WakelockPlus.disable();
    if (mounted) {
      setState(() {
        _isCreating = false;
        _progressCreated = 0;
        _progressErrors = 0;
        _successEmails.clear();
        _errorByKurzel.clear();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Import abgebrochen.')));
    }
  }

  Future<void> _printCredentials() async {
    final credentials = _batchResult?.credentials ?? [];
    if (credentials.isEmpty) return;
    final bytes = await StaffCredentialsPdfService.generatePdfBytes(
      credentials,
    );
    if (bytes.isEmpty || !mounted) return;
    await Printing.layoutPdf(
      onLayout: (_) async => Uint8List.fromList(bytes),
      name: 'Zugangsdaten_Benutzerimport.pdf',
    );
  }

  Future<void> _openPdfPreview() async {
    final credentials = _batchResult?.credentials ?? [];
    if (credentials.isEmpty) return;
    final file = await StaffCredentialsPdfService.generatePdfFile(credentials);
    if (file == null || !mounted) return;
    if (!mounted) return;
    await context.push(RoutePaths.utilPdfViewer, extra: {
      'pdfGenerator': () async => file,
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.upload_file,
        title: 'Benutzer aus Excel importieren',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Step 1: Pick file
                Text('1. Datei auswählen', style: context.typography.subtitle),
                const Gap(8),
                Button(
                  icon: const Icon(Icons.folder_open),
                  label: 'Excel-Datei auswählen (.xlsx)',
                  onPressed: _isCreating ? null : _pickFile,
                ),
                if (_parseResult != null) ...[
                  Gap(Style.spacing.md),
                  if (_parseResult!.hasErrors)
                    Container(
                      color: style.colors.error.withValues(alpha: 0.1),
                      padding: EdgeInsets.all(Style.spacing.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _parseResult!.errors
                            .map(
                              (e) =>
                                  Text(e, style: context.typography.bodySmall),
                            )
                            .toList(),
                      ),
                    ),
                  if (_parseResult!.rows.isNotEmpty) ...[
                    Gap(Style.spacing.md),
                    Text(
                      'Vorschau (${_parseResult!.rows.length} Zeilen)',
                      style: context.typography.bodySmall,
                    ),
                    const Gap(4),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: DataTable(
                          headingRowColor: WidgetStateProperty.all(
                            style.colors.surfaceContainer,
                          ),
                          columns: const [
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Vorname')),
                            DataColumn(label: Text('Nachname')),
                            DataColumn(label: Text('Kürzel')),
                            DataColumn(label: Text('Amtsbez.')),
                            DataColumn(label: Text('E-Mail')),
                            DataColumn(label: Text('Rolle')),
                            DataColumn(label: Text('Pflichtst.')),
                            DataColumn(label: Text('Relief')),
                          ],
                          rows: _parseResult!.rows.map((row) {
                            final isSuccess = _successEmails.contains(
                              row.email,
                            );
                            final isError = _errorByKurzel.containsKey(
                              row.kurzel,
                            );
                            return DataRow(
                              color: WidgetStateProperty.resolveWith((_) {
                                if (isSuccess) {
                                  return style.colors.success.withValues(
                                    alpha: 0.1,
                                  );
                                }
                                if (isError) {
                                  return style.colors.error.withValues(
                                    alpha: 0.1,
                                  );
                                }
                                return null;
                              }),
                              cells: [
                                DataCell(_buildStatusCell(row)),
                                DataCell(Text(row.firstName)),
                                DataCell(Text(row.lastName)),
                                DataCell(Text(row.kurzel)),
                                DataCell(Text(row.amtsbezeichnung)),
                                DataCell(Text(row.email)),
                                DataCell(Text(row.role.name)),
                                DataCell(Text('${row.timeUnits}')),
                                DataCell(Text('${row.reliefTimeUnits}')),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Gap(Style.spacing.lg),
                    // Step 2: Create users
                    Text(
                      '2. Benutzer anlegen',
                      style: context.typography.subtitle,
                    ),
                    const Gap(8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Button(
                              icon: _isCreating
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Spinner(
                                        color: style.colors.background,
                                      ),
                                    )
                                  : const Icon(Icons.person_add),
                              label: _isCreating
                                  ? 'Wird erstellt... ($_progressCreated / ${_parseResult!.rows.length}, $_progressErrors Fehler)'
                                  : 'Benutzer anlegen',
                              onPressed: _isCreating ? null : _createUsers,
                            ),
                          ),
                          if (_isCreating) ...[
                            Gap(Style.spacing.md),
                            Button.small(
                              onPressed: _abortCreate,
                              icon: const Icon(Icons.cancel_outlined),
                              label: 'Abbrechen',
                              variant: ButtonVariant.outline,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
                if (_batchResult != null) ...[
                  const Gap(20),
                  Text('Ergebnis', style: context.typography.subtitle),
                  const Gap(8),
                  Text(
                    '${_batchResult!.successCount} erstellt, ${_batchResult!.failureCount} Fehler.',
                    style: context.typography.bodySmall,
                  ),
                  if (_batchResult!.errors.isNotEmpty) ...[
                    const Gap(8),
                    ..._batchResult!.errors.map(
                      (e) => Padding(
                        padding: EdgeInsets.only(bottom: Style.spacing.xs),
                        child: Text(
                          'Zeile ${e.rowIndex} (${e.userNameOrKurzel}): ${e.message}',
                          style: context.typography.bodySmall.withColor(
                            style.colors.error,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (_batchResult!.credentials.isNotEmpty) ...[
                    Gap(Style.spacing.lg),
                    Text(
                      '3. Zugangsdaten drucken',
                      style: context.typography.subtitle,
                    ),
                    const Gap(8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Button(
                            icon: const Icon(Icons.print),
                            label: 'Drucken',
                            onPressed: _printCredentials,
                          ),
                        ),
                        Gap(Style.spacing.md),
                        Button.small(
                          onPressed: _openPdfPreview,
                          icon: const Icon(Icons.picture_as_pdf),
                          label: 'PDF-Vorschau',
                          variant: ButtonVariant.outline,
                        ),
                      ],
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const ActionBar(),
    );
  }
}
