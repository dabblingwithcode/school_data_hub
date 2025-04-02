class EnvsInStorage {
  final String defaultEnv;
  final Map<String, Env> environmentsMap;

  EnvsInStorage({required this.defaultEnv, required this.environmentsMap});

  EnvsInStorage copyWith({
    String? defaultEnv,
    Map<String, Env>? environmentsMap,
  }) =>
      EnvsInStorage(
        defaultEnv: defaultEnv ?? this.defaultEnv,
        environmentsMap: environmentsMap ?? this.environmentsMap,
      );

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
  final String name;
  final String key;
  final String iv;
  final String serverUrl;

  Env({
    required this.name,
    required this.key,
    required this.iv,
    required this.serverUrl,
  });

  factory Env.fromJson(Map<String, dynamic> json) => Env(
        name: json["server"],
        key: json["key"],
        iv: json["iv"],
        serverUrl: json["server_url"],
      );

  Map<String, dynamic> toJson() => {
        "server": name,
        "key": key,
        "iv": iv,
        "server_url": serverUrl,
      };
}
