enum SubjectEnum {
  english('Englisch', 'E', 'assets/images/learning_icons/english.png'),
  englishWorkbook(
    'Englisch Arbeitsheft',
    'EW',
    'assets/images/learning_icons/english_workbook.png',
  ),
  math('Mathematik', 'M', 'assets/images/learning_icons/math.png'),
  mathWorkbook(
    'Mathematik Arbeitsheft',
    'MW',
    'assets/images/learning_icons/math_workbook.png',
  ),
  music('Musik', 'M', 'assets/images/learning_icons/music.png'),
  art('Kunst', 'K', 'assets/images/learning_icons/art.png'),
  grammar('Rechtschreibung', 'G', 'assets/images/learning_icons/grammar.png'),
  writing('Schreiben', 'S', 'assets/images/learning_icons/writing.png'),
  reading('Lesen', 'L', 'assets/images/learning_icons/reading.png'),

  germanSupport(
    'Deutsch Förderheft',
    'DF',
    'assets/images/learning_icons/daz.png',
  ),
  science('Sachunterricht', 'SU', 'assets/images/learning_icons/science.png');

  final String name;
  final String code;
  final String? imagePath;

  const SubjectEnum(this.name, this.code, [this.imagePath]);
}

enum Grade {
  e1('E1', 'assets/images/grade_icons/grade_1.png'),
  e1F('E1F', 'assets/images/grade_icons/grade_1_f.png'),
  e2('E2', 'assets/images/grade_icons/grade_2.png'),
  e2F('E2F', 'assets/images/grade_icons/grade_2_f.png'),
  k3('K3', 'assets/images/grade_icons/grade_3.png'),
  k3F('K3F', 'assets/images/grade_icons/grade_3_f.png'),
  k4('K4', 'assets/images/grade_icons/grade_4.png'),
  k4F('K4F', 'assets/images/grade_icons/grade_4_f.png');

  final String name;
  final String imagePath;
  const Grade(this.name, this.imagePath);
}
