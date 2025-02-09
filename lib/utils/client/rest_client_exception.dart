import 'package:flutter/foundation.dart';

import './rest_client.dart';

// coverage:ignore-start

/// {@template rest_client_exception}
/// Базовый класс для всех ошибок [RestClient]
/// {@endtemplate}
@immutable
abstract base class RestClientException implements Exception {
  /// {@macro network_exception}
  const RestClientException({
    required this.message,
    this.statusCode,
    this.cause,
  });

  /// Сообщение исключения
  final String message;

  /// Статус-код ошибки (если есть)
  final int? statusCode;

  /// Причина исключения, если она является объектом другого типа
  final Object? cause;
}

/// {@template client_exception}
/// [ClientException] пробрасывается в результате исключения на стороне клиента
/// {@endtemplate}
final class ClientException extends RestClientException {
  /// {@macro client_exception}
  const ClientException({
    required super.message,
    super.statusCode,
    super.cause,
  });

  @override
  String toString() => 'ClientException('
      'message: $message, '
      'statusCode: $statusCode, '
      'cause: $cause'
      ')';
}

/// {@template structured_backend_exception}
/// Исключение используется для структурированных ошибок бэкенда
///
/// [error] - это Map, содержащая вложенные ошибки
///
/// Ошибка, созданная в результате исключения [RestClientBase] когда запрос содержит
/// 'error' поле, подобное представленному ниже:
/// ```json
/// {
///  "error": {
///   "message": "Some error message",
///   "code": 123
/// }
/// ```
///
/// Этот класс существует, чтобы упростить обработку структурированных ошибок.
/// В принципе, в провайдерах данных, использующих [RestClientBase], можно отловить
/// это исключение и преобразовать его в общесистемную ошибку. Например,
/// если бэкенд возвращает ошибку с кодом 123, это означает, что действие
/// не разрешено, вы можете преобразовать это исключение в NotAllowedException
/// и перебросить. Таким образом, остальной части приложения не нужно знать
/// о структуре ошибки и должна обрабатываться только в масштабе всей системы исключений.
/// {@endtemplate}
final class StructuredBackendException extends RestClientException {
  /// {@macro structured_backend_exception}
  const StructuredBackendException({required this.error, super.statusCode})
      : super(message: 'Backend returned structured error');

  /// Ошибка, которую вернул бэкенд
  final Map<String, Object?> error;

  @override
  String toString() => 'StructuredBackendException('
      'message: $message, '
      'error: $error, '
      'statusCode: $statusCode, '
      ')';
}

/// {@template wrong_response_type_exception}
/// [WrongResponseTypeException] пробрасывается, когда тип ответа
/// не соответствует ожидаемому
/// {@endtemplate}
final class WrongResponseTypeException extends RestClientException {
  /// {@macro wrong_response_type_exception}
  const WrongResponseTypeException({
    required super.message,
    super.statusCode,
  });

  @override
  String toString() => 'WrongResponseTypeException('
      'message: $message, '
      'statusCode: $statusCode, '
      ')';
}

/// {@template connection_exception}
/// [ConnectionException] пробрасывается, когда есть проблемы с соединением
/// {@endtemplate}
final class ConnectionException extends RestClientException {
  /// {@macro connection_exception}
  const ConnectionException({
    required super.message,
    super.statusCode,
    super.cause,
  });

  @override
  String toString() => 'ConnectionException('
      'message: $message, '
      'statusCode: $statusCode, '
      'cause: $cause'
      ')';
}

/// {@template internal_server_exception}
/// Пробрасывается, когда что-то пошло не так на стороне сервера
/// {@endtemplate}
final class InternalServerException extends RestClientException {
  /// {@macro internal_server_exception}
  const InternalServerException({
    required super.message,
    super.statusCode,
    super.cause,
  });

  @override
  String toString() => 'InternalServerException('
      'message: $message, '
      'statusCode: $statusCode, '
      'cause: $cause'
      ')';
}
// coverage:ignore-end
