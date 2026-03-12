import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:printing/printing.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/user/data/staff_excel_import_parser.dart';
import 'package:school_data_hub_flutter/features/user/domain/batch_create_result.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/batch_import_users/staff_credentials_pdf_service.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

final _log = Logger('BatchImportUsersPage');

class BatchImportUsersPage extends StatefulWidget {
  const BatchImportUsersPage({super.key});

  @override
  State<BatchImportUsersPage> createState() => _BatchImportUsersPageState();
}

class _BatchImportUsersPageState extends State<BatchImportUsersPage> {
  StaffImportParseResult? _parseResult;
  BatchCreateResult? _batchResult;
  bool _isCreating = false;
  int _progressCreated = 0;
  int _progressErrors = 0;
  StreamSubscription<BatchCreateResult>? _chunkSubscription;

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
          });
          _log.info(
            '[BatchImport] Chunk done — created=${chunkResult.successCount}, '
            'errors=${chunkResult.failureCount}, '
            'total created=$_progressCreated, total errors=$_progressErrors',
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
    await Navigator.of(context).push<void>(
      MaterialPageRoute(builder: (context) => PdfViewerPage(pdfFile: file)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.upload_file,
        title: 'Benutzer aus Excel importieren',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Step 1: Pick file
                const Text('1. Datei auswählen', style: AppStyles.subtitle),
                const Gap(8),
                ElevatedButton.icon(
                  style: AppStyles.actionButtonStyle,
                  onPressed: _isCreating ? null : _pickFile,
                  icon: const Icon(Icons.folder_open),
                  label: const Text('Excel-Datei auswählen (.xlsx)'),
                ),
                if (_parseResult != null) ...[
                  const Gap(12),
                  if (_parseResult!.hasErrors)
                    ColoredBox(
                      color: Colors.red.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _parseResult!.errors
                              .map(
                                (e) => Text(
                                  e,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  if (_parseResult!.rows.isNotEmpty) ...[
                    const Gap(12),
                    Text(
                      'Vorschau (${_parseResult!.rows.length} Zeilen)',
                      style: AppStyles.textLabel,
                    ),
                    const Gap(4),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: DataTable(
                          headingRowColor: WidgetStateProperty.all(
                            Colors.grey.shade300,
                          ),
                          columns: const [
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
                            return DataRow(
                              cells: [
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
                    const Gap(16),
                    // Step 2: Create users
                    const Text(
                      '2. Benutzer anlegen',
                      style: AppStyles.subtitle,
                    ),
                    const Gap(8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton.icon(
                            style: AppStyles.actionButtonStyle.copyWith(
                              minimumSize: WidgetStateProperty.all(
                                const Size(0, 50),
                              ),
                            ),
                            onPressed: _isCreating ? null : _createUsers,
                            icon: _isCreating
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.person_add),
                            label: Text(
                              _isCreating
                                  ? 'Wird erstellt… ($_progressCreated / ${_parseResult!.rows.length}, $_progressErrors Fehler)'
                                  : 'Benutzer anlegen',
                            ),
                          ),
                          if (_isCreating) ...[
                            const Gap(12),
                            OutlinedButton.icon(
                              onPressed: _abortCreate,
                              icon: const Icon(Icons.cancel_outlined),
                              label: const Text('Abbrechen'),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
                if (_batchResult != null) ...[
                  const Gap(20),
                  const Text('Ergebnis', style: AppStyles.subtitle),
                  const Gap(8),
                  Text(
                    '${_batchResult!.successCount} erstellt, ${_batchResult!.failureCount} Fehler.',
                    style: AppStyles.textLabel,
                  ),
                  if (_batchResult!.errors.isNotEmpty) ...[
                    const Gap(8),
                    ..._batchResult!.errors.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          'Zeile ${e.rowIndex} (${e.userNameOrKurzel}): ${e.message}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red.shade800,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (_batchResult!.credentials.isNotEmpty) ...[
                    const Gap(16),
                    const Text(
                      '3. Zugangsdaten drucken',
                      style: AppStyles.subtitle,
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          style: AppStyles.actionButtonStyle,
                          onPressed: _printCredentials,
                          icon: const Icon(Icons.print),
                          label: const Text('Drucken'),
                        ),
                        const Gap(12),
                        OutlinedButton.icon(
                          onPressed: _openPdfPreview,
                          icon: const Icon(Icons.picture_as_pdf),
                          label: const Text('PDF-Vorschau'),
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
      bottomNavigationBar: const GenericBottomNavBar(),
    );
  }
}
