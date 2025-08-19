class MatrixCredentials {
  final String url;
  final String matrixToken;
  final String policyToken;
  final String matrixAdmin;

  MatrixCredentials({
    required this.url,
    required this.matrixToken,
    required this.policyToken,
    required this.matrixAdmin,
  });

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'matrixToken': matrixToken,
      'policyToken': policyToken,
      'matrixAdmin': matrixAdmin,
    };
  }

  factory MatrixCredentials.fromJson(Map<String, dynamic> json) {
    return MatrixCredentials(
      url: json['url'],
      matrixToken: json['matrixToken'],
      policyToken: json['policyToken'],
      matrixAdmin: json['matrixAdmin'],
    );
  }
}
