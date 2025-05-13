enum BorrowedStatus {
  available('verfügbar'),
  borrowed('ausgeliehen'),
  all('alle');

  final String value;
  const BorrowedStatus(this.value);
  static const stringToValue = {
    'verfügbar': BorrowedStatus.available,
    'ausgeliehen': BorrowedStatus.borrowed,
    'alle': BorrowedStatus.all,
  };
}

enum ReadingLevel {
  beginner('Anfänger'),
  easy('leicht'),
  medium('mittel'),
  hard('schwer'),
  notSet('nicht angegeben');

  final String value;
  static ReadingLevel fromString(String value) {
    switch (value) {
      case 'Anfänger':
        return ReadingLevel.beginner;
      case 'leicht':
        return ReadingLevel.easy;
      case 'mittel':
        return ReadingLevel.medium;
      case 'schwer':
        return ReadingLevel.hard;
      case 'nicht angegeben':
        return ReadingLevel.notSet;
      default:
        return ReadingLevel.notSet;
    }
  }

  const ReadingLevel(this.value);
}
