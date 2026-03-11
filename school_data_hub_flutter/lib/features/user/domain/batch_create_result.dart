/// Result of batch creating users from import rows.
class BatchCreateResult {
  const BatchCreateResult({
    required this.credentials,
    required this.errors,
  });

  final List<StaffCredentialEntry> credentials;
  final List<BatchCreateError> errors;

  int get successCount => credentials.length;
  int get failureCount => errors.length;
}

/// One created user's credentials to print.
class StaffCredentialEntry {
  const StaffCredentialEntry({
    required this.userName,
    required this.fullName,
    required this.email,
    required this.password,
  });

  final String userName;
  final String fullName;
  final String email;
  final String password;
}

/// One failed row with reason.
class BatchCreateError {
  const BatchCreateError({
    required this.rowIndex,
    required this.userNameOrKurzel,
    required this.message,
  });

  final int rowIndex;
  final String userNameOrKurzel;
  final String message;
}
