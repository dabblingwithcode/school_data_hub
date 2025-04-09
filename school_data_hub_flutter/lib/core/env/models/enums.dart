enum HubRunMode {
  development,
  production,
  staging,
  test;

  // Serialize to JSON
  String toJson() => name;

  // Deserialize from JSON
  static HubRunMode fromJson(String json) =>
      HubRunMode.values.firstWhere((e) => e.name == json);
}
