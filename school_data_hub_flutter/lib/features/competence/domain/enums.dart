enum RootCompetenceType {
  science('Sachunterricht'),
  english('Englisch'),
  math('Mathematik'),
  music('Musik'),
  art('Kunst'),
  religion('Religion'),
  sport('Sport'),
  socialAndWorkSkills('Arbeits- und Sozialverhalten'),
  motherLanguage('Herkunftsprachlicher Unterricht'),
  german('Deutsch');

  final String value;

  static const stringToValue = {
    'Deutsch': RootCompetenceType.german,
    'Mathematik': RootCompetenceType.math,
    'Sachunterricht': RootCompetenceType.science,
    'Englisch': RootCompetenceType.english,
    'Kunst': RootCompetenceType.art,
    'Musik': RootCompetenceType.music,
    'Sport': RootCompetenceType.sport,
    'Religion': RootCompetenceType.religion,
    'Arbeits- und Sozialverhalten': RootCompetenceType.socialAndWorkSkills,
    'Herkunftsprachlicher Unterricht': RootCompetenceType.motherLanguage,
  };

  const RootCompetenceType(this.value);
}
