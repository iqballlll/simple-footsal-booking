class ApiException implements Exception {
  final int? code;
  final String? message;
  final Map<String, dynamic>? data;
  const ApiException({
    this.code,
    this.message,
    this.data,
  });
}
