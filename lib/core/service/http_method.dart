mixin HttpMethod {
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? param,
    showLog = false,
  });
  Future<dynamic> post<T>(
    String url, {
    T? data,
    showLog = false,
  });
  Future<dynamic> put<T>(
    String url, {
    T? data,
    showLog = false,
  });
  Future<dynamic> delete<T>(
    String url, {
    Map<String, dynamic>? param,
    showLog = false,
  });
}
