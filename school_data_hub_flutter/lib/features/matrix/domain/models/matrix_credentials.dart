class MatrixCredentials {
  final String url;
  final String matrixToken;
  final String policyToken;
  List<String>? compulsoryRooms;

  MatrixCredentials({
    required this.url,
    required this.matrixToken,
    required this.policyToken,
    this.compulsoryRooms,
  });

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'matrixToken': matrixToken,
      'policyToken': policyToken,
      'compulsoryRooms': compulsoryRooms,
    };
  }

  factory MatrixCredentials.fromJson(Map<String, dynamic> json) {
    return MatrixCredentials(
      url: json['url'],
      matrixToken: json['matrixToken'],
      policyToken: json['policyToken'],
      compulsoryRooms: json['compulsoryRooms'],
    );
  }
}
