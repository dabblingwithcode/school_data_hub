class MatrixCredentials {
  final String url;
  final String userServerAddress;
  final String matrixToken;
  final String policyToken;
  final String matrixAdmin;
  final String encryptionKey;

  MatrixCredentials({
    required this.url,
    required this.userServerAddress,
    required this.matrixToken,
    required this.policyToken,
    required this.matrixAdmin,
    required this.encryptionKey,
  });

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'userServerAddress': userServerAddress,
      'matrixToken': matrixToken,
      'policyToken': policyToken,
      'matrixAdmin': matrixAdmin,
      'encryptionKey': encryptionKey,
    };
  }

  factory MatrixCredentials.fromJson(Map<String, dynamic> json) {
    return MatrixCredentials(
      url: json['url'] as String,
      userServerAddress: json['userServerAddress'] as String,
      matrixToken: json['matrixToken'] as String,
      policyToken: json['policyToken'] as String,
      matrixAdmin: json['matrixAdmin'] as String,
      encryptionKey: json['encryptionKey'] as String,
    );
  }
}
