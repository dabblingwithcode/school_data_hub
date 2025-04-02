class SchoolData {
  final String name;
  final String? predicate;
  final String address;
  final String schoolNumber;

  final String logo;

  SchoolData({
    required this.name,
    this.predicate,
    required this.address,
    required this.schoolNumber,
    required this.logo,
  });

  factory SchoolData.fromJson(Map<String, dynamic> json) {
    return SchoolData(
      name: json['name'],
      predicate: json['predicate'],
      address: json['address'],
      schoolNumber: json['schoolNumber'],
      logo: json['logo'],
    );
  }
}

final schoolData = SchoolData(
  name: 'GGS Hermannstraße',
  predicate: 'Internationale Begegnungsschule',
  address: 'Hermannstraße 5, 52222 Stolberg',
  schoolNumber: '117146',
  logo: 'assets/images/school_logo.png',
);
