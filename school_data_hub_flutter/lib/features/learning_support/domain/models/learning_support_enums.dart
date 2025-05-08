enum SupportLevelType {
  supportLevel1,
  supportLevel2,
  supportLevel3,
  supportLevel4,
  specialNeeds,
  migrationSupport,
}

Map<SupportLevelType, bool> initialSupportLevelFilterValues = {
  SupportLevelType.supportLevel1: false,
  SupportLevelType.supportLevel2: false,
  SupportLevelType.supportLevel3: false,
  SupportLevelType.supportLevel4: false,
  SupportLevelType.specialNeeds: false,
  SupportLevelType.migrationSupport: false,
};

enum SupportArea {
  motorics(1),
  emotions(2),
  math(3),
  learning(4),
  german(5),
  language(6);

  static const intToValue = {
    1: SupportArea.motorics,
    2: SupportArea.emotions,
    3: SupportArea.math,
    4: SupportArea.learning,
    5: SupportArea.german,
    6: SupportArea.language,
  };

  final int value;
  const SupportArea(this.value);
}

Map<SupportArea, bool> initialSupportAreaFilterValues = {
  SupportArea.motorics: false,
  SupportArea.language: false,
  SupportArea.math: false,
  SupportArea.german: false,
  SupportArea.emotions: false,
  SupportArea.learning: false,
};
