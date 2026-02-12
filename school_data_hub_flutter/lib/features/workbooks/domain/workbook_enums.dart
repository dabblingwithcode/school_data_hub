enum Subject {
  german('Deutsch', 'D'),
  english('Englisch', 'E'),
  math('Mathematik', 'M'),
  physics('Physik', 'P'),
  chemistry('Chemie', 'C'),
  biology('Biologie', 'B'),
  history('Geschichte', 'H'),
  geography('Geografie', 'G'),
  music('Musik', 'M'),
  art('Kunst', 'K');

  final String name;
  final String code;

  const Subject(this.name, this.code);
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
