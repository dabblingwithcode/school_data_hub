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
  e1('E1', 'assets/grade_1.png'),
  e1F('E1F', 'assets/grade_1.png'),
  e2('E2', 'assets/grade_2.png'),
  e2F('E2F', 'assets/grade_2.png'),
  k3('K3', 'assets/grade_3.png'),
  k3F('K3F', 'assets/grade_3.png'),
  k4F('K4F', 'assets/grade_4.png'),
  k4('K4', 'assets/grade_4.png');

  final String name;
  final String imagePath;
  const Grade(this.name, this.imagePath);
}
