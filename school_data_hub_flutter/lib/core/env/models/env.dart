import 'package:school_data_hub_flutter/core/env/models/enums.dart';

class EnvsInStorage {
  final String defaultEnv;
  final Map<String, Env> environmentsMap;

  EnvsInStorage({required this.defaultEnv, required this.environmentsMap});

  factory EnvsInStorage.fromJson(Map<String, dynamic> json) => EnvsInStorage(
    defaultEnv: json["defaultEnv"],
    environmentsMap: Map.from(
      json["environmentsMap"],
    ).map((k, v) => MapEntry<String, Env>(k, Env.fromJson(v))),
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
    serverUrl: this.serverUrl,
    lastIdentitiesUpdate: lastIdentitiesUpdate ?? this.lastIdentitiesUpdate,
    colorSchemeKey: colorSchemeKey ?? this.colorSchemeKey,
  );

  factory Env.fromJson(Map<String, dynamic> json) => Env(
    serverName: json["server_name"],
    runMode: HubRunMode.fromJson(json["run_mode"]),
    lastIdentitiesUpdate:
        json["lastIdentitiesUpdate"] != null
            ? DateTime.parse(json["lastIdentitiesUpdate"])
            : null,
    key: json["key"],
    iv: json["iv"],
    serverUrl: json["server_url"],
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
