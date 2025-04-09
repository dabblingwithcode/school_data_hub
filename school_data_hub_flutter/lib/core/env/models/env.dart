import 'package:school_data_hub_flutter/core/env/models/enums.dart';

class EnvsInStorage {
  final String defaultEnv;
  final Map<String, Env> environmentsMap;

  EnvsInStorage({required this.defaultEnv, required this.environmentsMap});

  factory EnvsInStorage.fromJson(Map<String, dynamic> json) => EnvsInStorage(
        defaultEnv: json["defalutEnv"],
        environmentsMap: Map.from(json["environmentsMap"])
            .map((k, v) => MapEntry<String, Env>(k, Env.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "defalutEnv": defaultEnv,
        "environmentsMap": environmentsMap,
      };
}

class Env {
  final String serverName;
  final HubRunMode runMode;
  final String key;
  final String iv;
  final String serverUrl;

  Env({
    required this.serverName,
    required this.runMode,
    required this.key,
    required this.iv,
    required this.serverUrl,
  });

  factory Env.fromJson(Map<String, dynamic> json) => Env(
        serverName: json["server_name"],
        runMode: HubRunMode.fromJson(json["run_mode"]),
        key: json["key"],
        iv: json["iv"],
        serverUrl: json["server_url"],
      );

  Map<String, dynamic> toJson() => {
        "server_name": serverName,
        "run_mode": runMode.toJson(),
        "key": key,
        "iv": iv,
        "server_url": serverUrl,
      };
}
