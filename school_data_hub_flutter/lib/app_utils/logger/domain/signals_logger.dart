// lib/app_utils/logger/signals_logger.dart
import 'package:school_data_hub_flutter/app_utils/logger/domain/log_service.dart';
import 'package:signals/signals_flutter.dart';
import 'package:watch_it/watch_it.dart';

class AppSignalsObserver extends SignalsObserver {
  bool _forwarding = false;

  void _forward(String msg) {
    if (_forwarding) return; // re-entry guard
    _forwarding = true;
    // Send straight to LogService; don't go through Logger.root
    di<LogService>().addLogString(
      message: msg,
      levelName: 'FINE',
      loggerName: 'Signals',
    );
    _forwarding = false;
  }

  @override
  void onSignalCreated<T>(Signal<T> signal, T value) {
    if (_shouldSkip(signal.debugLabel)) return;
    _forward(
      '[Signals] signal created: ${signal.debugLabel ?? 'unlabeled'} => $value',
    );
  }

  @override
  void onSignalUpdated<T>(Signal<T> signal, T value) {
    if (_shouldSkip(signal.debugLabel)) return;
    _forward(
      '[Signals] signal updated: ${signal.debugLabel ?? 'unlabeled'} => $value',
    );
  }

  @override
  void onComputedCreated<T>(Computed<T> computed) {
    if (_shouldSkip(computed.debugLabel)) return;
    _forward(
      '[Signals] computed created: ${computed.debugLabel ?? 'unlabeled'}',
    );
  }

  @override
  void onComputedUpdated<T>(Computed<T> computed, T value) {
    if (_shouldSkip(computed.debugLabel)) return;
    _forward(
      '[Signals] computed updated: ${computed.debugLabel ?? 'unlabeled'} => $value',
    );
  }

  bool _shouldSkip(String? label) {
    // Avoid logging changes to the log storage signals themselves
    return label != null && label.startsWith('logService');
  }
}
