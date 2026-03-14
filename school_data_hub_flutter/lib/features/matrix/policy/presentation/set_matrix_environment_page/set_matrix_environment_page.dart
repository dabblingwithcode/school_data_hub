import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/import_string_from_txt_file.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/flags.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/hook.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/hook_enums.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/matrix_credentials.dart';

class SetMatrixEnvironmentViewModel {
  final urlController = TextEditingController();
  final userServerAddressController = TextEditingController();
  final matrixAdminController = TextEditingController();
  final matrixTokenController = TextEditingController();
  final policyTokenController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  final editableFlags = ValueNotifier<MatrixPolicyFlags?>(null);
  final editableHooks = ValueNotifier<List<Hook>>([]);

  bool get isEditing => di.isRegistered<MatrixPolicyManager>();

  Future<void> prefillFromManager() async {
    if (!di.isRegistered<MatrixPolicyManager>()) return;
    try {
      final manager = await di.getAsync<MatrixPolicyManager>();
      final credentials = manager.getMatrixCredentials();
      urlController.text = credentials.url;
      userServerAddressController.text = credentials.userServerAddress;
      matrixTokenController.text = credentials.matrixToken;
      policyTokenController.text = credentials.policyToken;
      matrixAdminController.text = credentials.matrixAdmin;
      encryptionKeyController.text = credentials.encryptionKey;
      final policy = manager.matrixPolicy;
      if (policy != null) {
        editableFlags.value = MatrixPolicyFlags.withDefaults(policy.flags);
        editableHooks.value = List<Hook>.from(policy.hooks ?? []);
      }
    } catch (_) {
      // Manager not ready -- leave form empty
    }
  }

  String _normalizeMatrixBaseUrl(String rawUrl) {
    final trimmed = rawUrl.trim();
    final withoutScheme = trimmed.replaceFirst(
      RegExp(r'^(https?:\/\/)+', caseSensitive: false),
      '',
    );
    return withoutScheme.replaceFirst(RegExp(r'\/$'), '');
  }

  Future<void> setMatrixEnvironment() async {
    final normalizedUrl = _normalizeMatrixBaseUrl(urlController.text);
    final url = 'https://$normalizedUrl';
    final credentials = MatrixCredentials(
      url: url,
      userServerAddress: userServerAddressController.text,
      matrixToken: matrixTokenController.text,
      policyToken: policyTokenController.text,
      matrixAdmin: matrixAdminController.text,
      encryptionKey: encryptionKeyController.text,
    );
    if (di.isRegistered<MatrixPolicyManager>()) {
      final manager = await di.getAsync<MatrixPolicyManager>();
      await manager.setMatrixEnvironmentValues(
        url: url,
        userServerAddress: userServerAddressController.text,
        policyToken: policyTokenController.text,
        matrixToken: matrixTokenController.text,
        matrixAdmin: matrixAdminController.text,
        encryptionKey: encryptionKeyController.text,
      );
      await di.allReady();
      return;
    }
    await MatrixPolicyHelper.registerMatrixPolicyManager(
      passedCredentials: credentials,
    );
    await di.allReady();
  }

  void updateFlag(MatrixPolicyFlags Function(MatrixPolicyFlags) update) {
    final current = editableFlags.value;
    if (current == null) return;
    editableFlags.value = update(current);
  }

  Future<void> applyPolicyFlags() async {
    if (!di.isRegistered<MatrixPolicyManager>()) return;
    final manager = await di.getAsync<MatrixPolicyManager>();
    if (manager.matrixPolicy == null) return;
    final flags = editableFlags.value;
    if (flags == null) return;
    manager.setPolicyFlags(flags);
    await manager.applyPolicyChanges();
  }

  void updateHook(int index, Hook hook) {
    final list = List<Hook>.from(editableHooks.value);
    if (index < 0 || index >= list.length) return;
    list[index] = hook;
    editableHooks.value = list;
  }

  void addHook() {
    editableHooks.value = [...editableHooks.value, Hook()];
  }

  void removeHook(int index) {
    final list = List<Hook>.from(editableHooks.value);
    if (index < 0 || index >= list.length) return;
    list.removeAt(index);
    editableHooks.value = list;
  }

  Future<void> applyPolicyHooks() async {
    if (!di.isRegistered<MatrixPolicyManager>()) return;
    final manager = await di.getAsync<MatrixPolicyManager>();
    if (manager.matrixPolicy == null) return;
    manager.setPolicyHooks(editableHooks.value);
    await manager.applyPolicyChanges();
  }

  Future<bool> importAndApplyMatrixCredentials(String rawJson) async {
    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is! Map<String, dynamic>) return false;

      final credentials = MatrixCredentials.fromJson(decoded);
      urlController.text = _normalizeMatrixBaseUrl(credentials.url);
      userServerAddressController.text = credentials.userServerAddress;
      matrixTokenController.text = credentials.matrixToken;
      policyTokenController.text = credentials.policyToken;
      matrixAdminController.text = credentials.matrixAdmin;
      encryptionKeyController.text = credentials.encryptionKey;

      await setMatrixEnvironment();
      return true;
    } catch (_) {
      return false;
    }
  }

  void dispose() {
    urlController.dispose();
    userServerAddressController.dispose();
    matrixAdminController.dispose();
    matrixTokenController.dispose();
    policyTokenController.dispose();
    encryptionKeyController.dispose();
    editableFlags.dispose();
    editableHooks.dispose();
  }
}

class SetMatrixEnvironmentPage extends WatchingWidget {
  const SetMatrixEnvironmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = createOnce(() => SetMatrixEnvironmentViewModel());
    callOnce((_) => vm.prefillFromManager());
    final flags = watch(vm.editableFlags).value;
    final hooks = watch(vm.editableHooks).value;
    return Scaffold(
      appBar: GenericAppBar(
        iconData: Icons.settings,
        title: vm.isEditing
            ? 'Matrix-Umgebung bearbeiten'
            : 'Matrix-Umgebung einrichten',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Section 1: Matrix-Zugangsdaten (Verbindung)
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '1. Matrix-Zugangsdaten',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            'Verbindung zum Matrix-Server und Corporal konfigurieren.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          const Gap(20),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            runSpacing: 8,
                            children: [
                              const Text(
                                'Matrix-URL:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'https://',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 300,
                                child: TextField(
                                  minLines: 1,
                                  maxLines: 3,
                                  controller: vm.urlController,
                                  decoration: AppStyles.textFieldDecoration(
                                    labelText: 'Matrix-URL',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          TextField(
                            controller: vm.userServerAddressController,
                            decoration: AppStyles.textFieldDecoration(
                              labelText: 'Matrix-Id Serveradresse',
                            ),
                          ),
                          const Gap(20),
                          TextField(
                            minLines: 1,
                            maxLines: 2,
                            controller: vm.matrixAdminController,
                            decoration: AppStyles.textFieldDecoration(
                              labelText: 'Matrix-Admin ID',
                            ),
                          ),
                          const Gap(20),
                          TextField(
                            minLines: 1,
                            maxLines: 2,
                            controller: vm.matrixTokenController,
                            decoration: AppStyles.textFieldDecoration(
                              labelText: 'Matrix-Admin Token',
                            ),
                          ),
                          const Gap(20),
                          TextField(
                            minLines: 1,
                            maxLines: 2,
                            controller: vm.policyTokenController,
                            decoration: AppStyles.textFieldDecoration(
                              labelText: 'Matrix-Corporal Token',
                            ),
                          ),
                          const Gap(20),
                          TextField(
                            minLines: 1,
                            maxLines: 2,
                            controller: vm.encryptionKeyController,
                            decoration: AppStyles.textFieldDecoration(
                              labelText: 'Encryption Key',
                            ),
                          ),
                          const Gap(24),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              ElevatedButton(
                                style: AppStyles.successButtonStyle,
                                onPressed: () async {
                                  await vm.setMatrixEnvironment();
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  'Zugangsdaten speichern',
                                  style: AppStyles.buttonTextStyle,
                                ),
                              ),
                              ElevatedButton(
                                style: AppStyles.successButtonStyle,
                                onPressed: () async {
                                  String? scanResult;
                                  if (Platform.isAndroid || Platform.isIOS) {
                                    scanResult = await qrScanner(
                                      context: context,
                                      overlayText:
                                          'Matrix Zugangsdaten scannen',
                                    );
                                  }
                                  if (Platform.isWindows ||
                                      Platform.isLinux ||
                                      Platform.isMacOS) {
                                    scanResult =
                                        await importStringfromTxtFile();
                                  }
                                  if (scanResult != null) {
                                    final success = await vm
                                        .importAndApplyMatrixCredentials(
                                          scanResult,
                                        );
                                    if (success && context.mounted) {
                                      Navigator.pop(context);
                                    } else {
                                      di<NotificationManager>().showSnackBar(
                                        NotificationType.error,
                                        'Ungültige Matrix-Zugangsdaten',
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  (Platform.isAndroid || Platform.isIOS)
                                      ? 'Zugangsdaten scannen'
                                      : 'Import aus Datei',
                                  style: AppStyles.buttonTextStyle,
                                ),
                              ),
                              ElevatedButton(
                                style: AppStyles.cancelButtonStyle,
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Abbrechen',
                                  style: AppStyles.buttonTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (flags != null) ...[
                    const Gap(24),
                    // Section 2: Corporal-Richtlinie (Flags & Hooks)
                    Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '2. Corporal-Richtlinie',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              'Richtlinien-Flags und Hooks auf dem Corporal-Server bearbeiten und anwenden.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            const Gap(24),
                            _FlagsSection(vm: vm, flags: flags),
                            const Gap(24),
                            _HooksSection(vm: vm, hooks: hooks),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FlagsSection extends StatelessWidget {
  const _FlagsSection({required this.vm, required this.flags});

  final SetMatrixEnvironmentViewModel vm;
  final MatrixPolicyFlags flags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Richtlinien-Flags',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Gap(8),
        _flagSwitch(
          label: 'Benutzer-Anzeigenamen erlauben',
          value: flags.allowCustomUserDisplayNames ?? false,
          onChanged: (v) =>
              vm.updateFlag((f) => f.copyWith(allowCustomUserDisplayNames: v)),
        ),
        _flagSwitch(
          label: 'Benutzer-Avatare erlauben',
          value: flags.allowCustomUserAvatars ?? false,
          onChanged: (v) =>
              vm.updateFlag((f) => f.copyWith(allowCustomUserAvatars: v)),
        ),
        _flagSwitch(
          label: 'Passthrough-Passwörter erlauben',
          value: flags.allowCustomPassthroughUserPasswords ?? false,
          onChanged: (v) => vm.updateFlag(
            (f) => f.copyWith(allowCustomPassthroughUserPasswords: v),
          ),
        ),
        _flagSwitch(
          label: 'Passwort-Reset ohne Auth erlauben',
          value: flags.allowUnauthenticatedPasswordResets ?? false,
          onChanged: (v) => vm.updateFlag(
            (f) => f.copyWith(allowUnauthenticatedPasswordResets: v),
          ),
        ),
        _flagSwitch(
          label: 'Raumerstellung verbieten',
          value: flags.forbidRoomCreation ?? false,
          onChanged: (v) =>
              vm.updateFlag((f) => f.copyWith(forbidRoomCreation: v)),
        ),
        _flagSwitch(
          label: 'Verschlüsselte Raumerstellung verbieten',
          value: flags.forbidEncryptedRoomCreation ?? false,
          onChanged: (v) =>
              vm.updateFlag((f) => f.copyWith(forbidEncryptedRoomCreation: v)),
        ),
        _flagSwitch(
          label: 'Unverschlüsselte Raumerstellung verbieten',
          value: flags.forbidUnencryptedRoomCreation ?? false,
          onChanged: (v) => vm.updateFlag(
            (f) => f.copyWith(forbidUnencryptedRoomCreation: v),
          ),
        ),
        _flagSwitch(
          label: '3PID-Login erlauben',
          value: flags.allow3pidLogin ?? false,
          onChanged: (v) => vm.updateFlag((f) => f.copyWith(allow3pidLogin: v)),
        ),
        const Gap(8),
        ElevatedButton(
          style: AppStyles.successButtonStyle,
          onPressed: () async {
            await vm.applyPolicyFlags();
          },
          child: const Text(
            'Flags speichern',
            style: AppStyles.buttonTextStyle,
          ),
        ),
      ],
    );
  }

  Widget _flagSwitch({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }
}

class _HooksSection extends StatelessWidget {
  const _HooksSection({required this.vm, required this.hooks});

  final SetMatrixEnvironmentViewModel vm;
  final List<Hook> hooks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hooks',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Gap(8),
        for (int i = 0; i < hooks.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: _HookTile(hook: hooks[i], index: i, vm: vm),
          ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              style: AppStyles.successButtonStyle,
              onPressed: vm.addHook,
              child: const Text(
                'Hook hinzufügen',
                style: AppStyles.buttonTextStyle,
              ),
            ),
            ElevatedButton(
              style: AppStyles.successButtonStyle,
              onPressed: () async {
                await vm.applyPolicyHooks();
              },
              child: const Text(
                'Hooks speichern',
                style: AppStyles.buttonTextStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HookTile extends WatchingWidget {
  const _HookTile({required this.hook, required this.index, required this.vm});

  final Hook hook;
  final int index;
  final SetMatrixEnvironmentViewModel vm;

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce<CustomExpansionTileController>(
      () => CustomExpansionTileController(),
    );
    final title = hook.id?.isNotEmpty == true
        ? hook.id!
        : (hook.eventType?.isNotEmpty == true
              ? hook.eventType!
              : 'Hook ${index + 1}');

    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => vm.removeHook(index),
                  tooltip: 'Hook entfernen',
                ),
                CustomExpansionTileSwitch(
                  customExpansionTileController: tileController,
                  switchColor: Colors.black87,
                ),
              ],
            ),
          ),
          CustomExpansionTileContent(
            tileController: tileController,
            widgetList: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: _HookForm(hook: hook, index: index, vm: vm),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HookForm extends StatefulWidget {
  const _HookForm({required this.hook, required this.index, required this.vm});

  final Hook hook;
  final int index;
  final SetMatrixEnvironmentViewModel vm;

  @override
  State<_HookForm> createState() => _HookFormState();
}

class _HookFormState extends State<_HookForm> {
  late TextEditingController _idController;
  HookEventType? _eventTypeEnum;
  late TextEditingController _eventTypeCustomController;
  HookAction? _actionEnum;
  late TextEditingController _actionCustomController;
  late TextEditingController _responseStatusCodeController;
  late TextEditingController _rejectionErrorCodeController;
  late TextEditingController _rejectionErrorMessageController;
  late TextEditingController _restServiceUrlController;

  @override
  void initState() {
    super.initState();
    final h = widget.hook;
    _idController = TextEditingController(text: h.id ?? '');
    _eventTypeEnum = HookEventType.fromApiValue(h.eventType);
    _eventTypeCustomController = TextEditingController(
      text: _eventTypeEnum == null ? (h.eventType ?? '') : '',
    );
    _actionEnum = HookAction.fromApiValue(h.action);
    _actionCustomController = TextEditingController(
      text: _actionEnum == null ? (h.action ?? '') : '',
    );
    _responseStatusCodeController = TextEditingController(
      text: h.responseStatusCode?.toString() ?? '',
    );
    _rejectionErrorCodeController = TextEditingController(
      text: h.rejectionErrorCode ?? '',
    );
    _rejectionErrorMessageController = TextEditingController(
      text: h.rejectionErrorMessage ?? '',
    );
    _restServiceUrlController = TextEditingController(
      text: h.rESTServiceURL ?? '',
    );
  }

  @override
  void didUpdateWidget(_HookForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hook != widget.hook) {
      final h = widget.hook;
      _idController.text = h.id ?? '';
      _eventTypeEnum = HookEventType.fromApiValue(h.eventType);
      _eventTypeCustomController.text = _eventTypeEnum == null
          ? (h.eventType ?? '')
          : '';
      _actionEnum = HookAction.fromApiValue(h.action);
      _actionCustomController.text = _actionEnum == null
          ? (h.action ?? '')
          : '';
      _responseStatusCodeController.text =
          h.responseStatusCode?.toString() ?? '';
      _rejectionErrorCodeController.text = h.rejectionErrorCode ?? '';
      _rejectionErrorMessageController.text = h.rejectionErrorMessage ?? '';
      _restServiceUrlController.text = h.rESTServiceURL ?? '';
    }
  }

  String? get _effectiveEventType =>
      _eventTypeEnum?.apiValue ??
      (_eventTypeCustomController.text.isEmpty
          ? null
          : _eventTypeCustomController.text);

  String? get _effectiveAction =>
      _actionEnum?.apiValue ??
      (_actionCustomController.text.isEmpty
          ? null
          : _actionCustomController.text);

  List<MatchRules> get _matchRules => widget.hook.matchRules ?? const [];

  void _updateMatchRule(int ruleIndex, MatchRules rule) {
    final list = List<MatchRules>.from(_matchRules);
    if (ruleIndex < 0 || ruleIndex >= list.length) return;
    list[ruleIndex] = rule;
    widget.vm.updateHook(widget.index, widget.hook.copyWith(matchRules: list));
  }

  void _addMatchRule() {
    final list = List<MatchRules>.from(_matchRules)
      ..add(MatchRules(key: MatchRuleType.route.apiValue, regex: ''));
    widget.vm.updateHook(widget.index, widget.hook.copyWith(matchRules: list));
  }

  void _removeMatchRule(int ruleIndex) {
    final list = List<MatchRules>.from(_matchRules);
    if (ruleIndex < 0 || ruleIndex >= list.length) return;
    list.removeAt(ruleIndex);
    widget.vm.updateHook(widget.index, widget.hook.copyWith(matchRules: list));
  }

  void _notifyUpdate() {
    final statusCode = int.tryParse(_responseStatusCodeController.text);
    widget.vm.updateHook(
      widget.index,
      widget.hook.copyWith(
        id: _idController.text.isEmpty ? null : _idController.text,
        eventType: _effectiveEventType,
        action: _effectiveAction,
        responseStatusCode: statusCode,
        rejectionErrorCode: _rejectionErrorCodeController.text.isEmpty
            ? null
            : _rejectionErrorCodeController.text,
        rejectionErrorMessage: _rejectionErrorMessageController.text.isEmpty
            ? null
            : _rejectionErrorMessageController.text,
        rESTServiceURL: _restServiceUrlController.text.isEmpty
            ? null
            : _restServiceUrlController.text,
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    _eventTypeCustomController.dispose();
    _actionCustomController.dispose();
    _responseStatusCodeController.dispose();
    _rejectionErrorCodeController.dispose();
    _rejectionErrorMessageController.dispose();
    _restServiceUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _idController,
          decoration: AppStyles.textFieldDecoration(labelText: 'ID'),
          onChanged: (_) => _notifyUpdate(),
        ),
        const Gap(12),
        InputDecorator(
          decoration: AppStyles.textFieldDecoration(labelText: 'Event Type'),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<HookEventType?>(
              value: _eventTypeEnum,
              isExpanded: true,
              items: [
                ...HookEventType.values.map(
                  (e) => DropdownMenuItem<HookEventType?>(
                    value: e,
                    child: Text(e.label),
                  ),
                ),
                const DropdownMenuItem<HookEventType?>(
                  value: null,
                  child: Text('Other (custom)'),
                ),
              ],
              onChanged: (v) {
                setState(() {
                  _eventTypeEnum = v;
                  _eventTypeCustomController.text = v == null ? '' : '';
                });
                _notifyUpdate();
              },
            ),
          ),
        ),
        if (_eventTypeEnum == null) ...[
          const Gap(8),
          TextField(
            controller: _eventTypeCustomController,
            decoration: AppStyles.textFieldDecoration(
              labelText: 'Custom Event Type (API value)',
            ),
            onChanged: (_) => _notifyUpdate(),
          ),
        ],
        const Gap(12),
        InputDecorator(
          decoration: AppStyles.textFieldDecoration(labelText: 'Action'),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<HookAction?>(
              value: _actionEnum,
              isExpanded: true,
              items: [
                ...HookAction.values.map(
                  (e) => DropdownMenuItem<HookAction?>(
                    value: e,
                    child: Text(e.label),
                  ),
                ),
                const DropdownMenuItem<HookAction?>(
                  value: null,
                  child: Text('Other (custom)'),
                ),
              ],
              onChanged: (v) {
                setState(() {
                  _actionEnum = v;
                  _actionCustomController.text = v == null ? '' : '';
                });
                _notifyUpdate();
              },
            ),
          ),
        ),
        if (_actionEnum == null) ...[
          const Gap(8),
          TextField(
            controller: _actionCustomController,
            decoration: AppStyles.textFieldDecoration(
              labelText: 'Custom Action (API value)',
            ),
            onChanged: (_) => _notifyUpdate(),
          ),
        ],
        const Gap(12),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Match rules',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            TextButton.icon(
              onPressed: _addMatchRule,
              icon: const Icon(Icons.add),
              label: const Text('Add rule'),
            ),
          ],
        ),
        if (_matchRules.isEmpty)
          const Text(
            'No match rules. Add at least one to target a method/route/user.',
          )
        else
          for (int i = 0; i < _matchRules.length; i++) ...[
            Card(
              elevation: 0,
              margin: const EdgeInsets.only(top: 8),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: _MatchRuleRow(
                  rule: _matchRules[i],
                  onChanged: (r) => _updateMatchRule(i, r),
                  onRemove: () => _removeMatchRule(i),
                ),
              ),
            ),
          ],
        const Gap(12),
        TextField(
          controller: _responseStatusCodeController,
          decoration: AppStyles.textFieldDecoration(
            labelText: 'Response Status Code',
          ),
          keyboardType: TextInputType.number,
          onChanged: (_) => _notifyUpdate(),
        ),
        const Gap(12),
        TextField(
          controller: _rejectionErrorCodeController,
          decoration: AppStyles.textFieldDecoration(
            labelText: 'Rejection Error Code',
          ),
          onChanged: (_) => _notifyUpdate(),
        ),
        const Gap(12),
        TextField(
          controller: _rejectionErrorMessageController,
          minLines: 1,
          maxLines: 2,
          decoration: AppStyles.textFieldDecoration(
            labelText: 'Rejection Error Message',
          ),
          onChanged: (_) => _notifyUpdate(),
        ),
        const Gap(12),
        TextField(
          controller: _restServiceUrlController,
          decoration: AppStyles.textFieldDecoration(
            labelText: 'REST Service URL',
          ),
          onChanged: (_) => _notifyUpdate(),
        ),
      ],
    );
  }
}

class _MatchRuleRow extends StatefulWidget {
  const _MatchRuleRow({
    required this.rule,
    required this.onChanged,
    required this.onRemove,
  });

  final MatchRules rule;
  final ValueChanged<MatchRules> onChanged;
  final VoidCallback onRemove;

  @override
  State<_MatchRuleRow> createState() => _MatchRuleRowState();
}

class _MatchRuleRowState extends State<_MatchRuleRow> {
  MatchRuleType? _typeEnum;
  late TextEditingController _typeCustomController;
  late TextEditingController _regexController;

  @override
  void initState() {
    super.initState();
    _typeEnum = MatchRuleType.fromApiValue(widget.rule.key);
    _typeCustomController = TextEditingController(
      text: _typeEnum == null ? (widget.rule.key ?? '') : '',
    );
    _regexController = TextEditingController(text: widget.rule.regex ?? '');
  }

  @override
  void didUpdateWidget(_MatchRuleRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rule != widget.rule) {
      _typeEnum = MatchRuleType.fromApiValue(widget.rule.key);
      _typeCustomController.text = _typeEnum == null
          ? (widget.rule.key ?? '')
          : '';
      _regexController.text = widget.rule.regex ?? '';
    }
  }

  String? get _effectiveType =>
      _typeEnum?.apiValue ??
      (_typeCustomController.text.isEmpty ? null : _typeCustomController.text);

  void _notifyRuleChanged() {
    widget.onChanged(
      widget.rule.copyWith(
        key: _effectiveType,
        regex: _regexController.text.isEmpty ? null : _regexController.text,
      ),
    );
  }

  @override
  void dispose() {
    _typeCustomController.dispose();
    _regexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Rule',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              onPressed: widget.onRemove,
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Remove rule',
            ),
          ],
        ),
        InputDecorator(
          decoration: AppStyles.textFieldDecoration(labelText: 'Type'),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<MatchRuleType?>(
              value: _typeEnum,
              isExpanded: true,
              items: [
                ...MatchRuleType.values.map(
                  (e) => DropdownMenuItem<MatchRuleType?>(
                    value: e,
                    child: Text(e.label),
                  ),
                ),
                const DropdownMenuItem<MatchRuleType?>(
                  value: null,
                  child: Text('Other (custom)'),
                ),
              ],
              onChanged: (v) {
                setState(() {
                  _typeEnum = v;
                  _typeCustomController.text = v == null ? '' : '';
                });
                _notifyRuleChanged();
              },
            ),
          ),
        ),
        if (_typeEnum == null) ...[
          const Gap(8),
          TextField(
            controller: _typeCustomController,
            decoration: AppStyles.textFieldDecoration(
              labelText: 'Custom type (API value)',
            ),
            onChanged: (_) => _notifyRuleChanged(),
          ),
        ],
        const Gap(8),
        TextField(
          controller: _regexController,
          decoration: AppStyles.textFieldDecoration(labelText: 'Regex'),
          onChanged: (_) => _notifyRuleChanged(),
        ),
      ],
    );
  }
}
