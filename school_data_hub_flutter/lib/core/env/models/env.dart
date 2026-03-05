import 'package:school_data_hub_flutter/core/env/models/enums.dart';

class EnvsInStorage {
  final String defaultEnv;
  final Map<String, Env> environmentsMap;

  EnvsInStorage({required this.defaultEnv, required this.environmentsMap});

  factory EnvsInStorage.fromJson(Map<String, dynamic> json) => EnvsInStorage(
    defaultEnv: json["defaultEnv"] as String,
    environmentsMap: Map.from(json["environmentsMap"] as Map<dynamic, dynamic>)
        .map(
          (k, v) => MapEntry<String, Env>(
            k as String,
            Env.fromJson(v as Map<String, dynamic>),
          ),
        ),
  );

  Map<String, dynamic> toJson() => {
    "defaultEnv": defaultEnv,
    "environmentsMap": environmentsMap,
  };
}

class Env {
  final String serverName;
  final HubRunMode runMode;
  final String? key;
  final String? iv;
  final String serverUrl;
  final DateTime? lastIdentitiesUpdate;
  final String? colorSchemeKey;

  Env({
    required this.serverName,
    required this.runMode,
    this.key,
    this.iv,
    required this.serverUrl,
    this.lastIdentitiesUpdate,
    this.colorSchemeKey,
  });

  Env copyWith({
    String? serverName,
    HubRunMode? runMode,
    String? key,
    String? iv,
    DateTime? lastIdentitiesUpdate,
    String? colorSchemeKey,
  }) => Env(
    serverName: serverName ?? this.serverName,
    runMode: runMode ?? this.runMode,
    key: key ?? this.key,
    iv: iv ?? this.iv,
    serverUrl: serverUrl,
    lastIdentitiesUpdate: lastIdentitiesUpdate ?? this.lastIdentitiesUpdate,
    colorSchemeKey: colorSchemeKey ?? this.colorSchemeKey,
  );

  factory Env.fromJson(Map<String, dynamic> json) => Env(
    serverName: json["server_name"] as String,
    runMode: HubRunMode.fromJson(json["run_mode"] as String),
    lastIdentitiesUpdate: json["lastIdentitiesUpdate"] != null
        ? DateTime.parse(json["lastIdentitiesUpdate"] as String)
        : null,
    key: json["key"] as String?,
    iv: json["iv"] as String?,
    serverUrl: json["server_url"] as String,
    colorSchemeKey: json["color_scheme_key"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "server_name": serverName,
    "run_mode": runMode.toJson(),
    "lastIdentitiesUpdate": lastIdentitiesUpdate?.toIso8601String(),
    "key": key,
    "iv": iv,
    "server_url": serverUrl,
    "color_scheme_key": colorSchemeKey,
  };
}
