import '../typedefs.dart';

/// {@template rest_client}
/// A REST client for making HTTP requests.
/// {@endtemplate}
abstract class RestClient {
  /// Sends a GET request to the given [path].
  Future<JsonMap?> get(
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  });

  /// Sends a POST request to the given [path].
  Future<JsonMap?> post(
    String path, {
    Object? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  });

  /// Sends a PUT request to the given [path].
  Future<JsonMap?> put(
    String path, {
    JsonMap? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  });

  /// Sends a DELETE request to the given [path].
  Future<JsonMap?> delete(
    String path, {
    Map<String, Object?>? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  });

  /// Sends a PATCH request to the given [path].
  Future<JsonMap?> patch(
    String path, {
    required JsonMap body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  });
}
