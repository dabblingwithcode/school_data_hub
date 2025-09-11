class MatrixCredentials {
  final String url;
  final String matrixToken;
  final String policyToken;
  final String matrixAdmin;
  final String encryptionKey;
  final String encryptionIv;

  MatrixCredentials({
    required this.url,
    required this.matrixToken,
    required this.policyToken,
    required this.matrixAdmin,
    required this.encryptionKey,
    required this.encryptionIv,
  });

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'matrixToken': matrixToken,
      'policyToken': policyToken,
      'matrixAdmin': matrixAdmin,
      'encryptionKey': encryptionKey,
      'encryptionIv': encryptionIv,
    };
  }

  factory MatrixCredentials.fromJson(Map<String, dynamic> json) {
    return MatrixCredentials(
      url: json['url'],
      matrixToken: json['matrixToken'],
      policyToken: json['policyToken'],
      matrixAdmin: json['matrixAdmin'],
      encryptionKey: json['encryptionKey'],
      encryptionIv: json['encryptionIv'],
    );
  }
}
