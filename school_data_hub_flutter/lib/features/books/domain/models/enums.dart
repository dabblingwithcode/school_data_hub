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

enum BookFilter {
  all('Alle'),
  available('Verfügbar'),
  borrowed('Ausgeliehen');

  final String value;
  const BookFilter(this.value);
}

Map<BookFilter, bool> initialBookFilterValues = {
  BookFilter.all: true,
  BookFilter.available: false,
  BookFilter.borrowed: false,
};

enum PupilBookLendingFilter {
  all,
  currentlyBorrowed,
  returned,
  lastSevenDays,
  lastThirtyDays,
  highScore,
  lowScore,
  noScore,
}

Map<PupilBookLendingFilter, bool> initialPupilBookLendingFilterValues = {
  PupilBookLendingFilter.all: false,
  PupilBookLendingFilter.currentlyBorrowed: false,
  PupilBookLendingFilter.returned: false,
  PupilBookLendingFilter.lastSevenDays: false,
  PupilBookLendingFilter.lastThirtyDays: false,
  PupilBookLendingFilter.highScore: false,
  PupilBookLendingFilter.lowScore: false,
  PupilBookLendingFilter.noScore: false,
};
