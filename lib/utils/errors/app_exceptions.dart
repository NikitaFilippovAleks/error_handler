import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

import '../client/index.dart';
import '../typedefs.dart';
import 'inputs_exception_data.dart';

/// Те типы ошибок, которые могут быть обработы по разному в UI слое
/// Чаще всего при типе other мы либо берем сообщение/структуру от бэка, либо формируем
/// дефолтное сообщение на в нужном виджете/валидаторе
enum AppExceptionType {
  /// Ресурс/контент не найден
  notFound,

  /// Ошибка соединения
  connection,

  /// Ошибка с 401 кодом
  authentication,

  /// Прочие ошибки, где хотим вывести дефолтное сообщение, либо сообщение, если присутствует
  other,
}

/// {@template AppException$Base.class}
/// Базовый класс для формирования общей ошибки, обрабатываемой в UI слое
/// {@endtemplate}
@immutable
sealed class AppException$Base implements Exception {
  /// {@macro AppException$Base.class}
  const AppException$Base();

  AppExceptionType get type => AppExceptionType.other;

  /// Сообщение, которое мы можем вывести пользователю
  String? get message => switch (this) {
        AppException$Simple(:final messages) => messages?.firstOrNull,
        _ => null,
      };

  factory AppException$Base.fromRestClientException(RestClientException exception, StackTrace stackTrace) {
    /// Парсим структурную ошибку с бэка
    if (exception is StructuredBackendException) {
      if (exception.statusCode == 429) {
        return AppException$TooManyRequests.fromJson(exception.error);
      }

      /// Получаем только одно сообщение для вывода пользователю
      /// Если сообщение удалось извлечь- возаращаем данное исключение
      final simpleException = AppException$Simple.fromJson(exception.error, code: exception.statusCode);
      if (simpleException.messages != null) return simpleException;

      /// Пробуем распарсить структурированную ошибку как ошибку конкретных инпутов
      final inputsException = AppException$Inputs.fromJson(exception.error);
      if (!inputsException.isEmptyFields) return inputsException;

      /// Прочие случаи более сложной ошибки, парсится в зависимости от кейса
      return AppException$Structured(errors: exception.error, code: exception.statusCode);
    }

    /// Во всех остальных случаях возвращаем простую ошибку с попыткой преобразовать тип
    /// к конкретному, а также при неудачной попытке преобразования указываем тип
    /// [AppExceptionType.forceRethrow], чтобы пробросить ошибку дальше
    return AppException$Simple(
      code: exception.statusCode,
      type: switch (exception) {
        ConnectionException() => AppExceptionType.connection,
        _ when exception.statusCode == 401 => AppExceptionType.authentication,
        _ when exception.statusCode == 404 => AppExceptionType.notFound,

        /// Все ошибки, которые мы хотим отправить в крашлитику
        _ => Error.throwWithStackTrace(exception, stackTrace),
      },
    );
  }
}

/// {@template AppException$Simple.class}
/// Общий базовый класс для формирования ошибки с массивом сообщений
/// {@endtemplate}
@immutable
final class AppException$Simple extends AppException$Base {
  /// {@macro AppException$Simple.class}
  const AppException$Simple({this.code, this.messages, this.type = AppExceptionType.other});

  factory AppException$Simple.fromJson(JsonMap json, {int? code}) {
    List<String>? messages;
    final errors = json['errors'] as JsonList?;
    if (errors?.isNotEmpty ?? false) {
      messages = errors!.every((e) => e is String) ? errors.cast<String>() : null;
    }

    return AppException$Simple(code: code, messages: messages);
  }

  final int? code;

  /// Базовое решение пробрасывание ошибки с бэка обычно такое:
  /// ```json
  /// {
  ///  "errors": [
  ///   "Первое сообщение",
  ///   "Второе сообщение"
  ///   ]
  /// }
  /// ```
  ///
  final List<String>? messages;

  @override
  final AppExceptionType type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppException$Simple &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          messages == other.messages;

  @override
  int get hashCode => code.hashCode ^ messages.hashCode;
}

/// {@template AppException$Structured.class}
/// Класс с ошибкой многоуровневого формата
/// {@endtemplate}
@immutable
final class AppException$Structured extends AppException$Base {
  /// {@macro AppException$Structured.class}
  const AppException$Structured({this.code, required this.errors});

  final int? code;

  /// Структура ошибки с вложенностью неограниченного уровня
  final JsonMap errors;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppException$Structured &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          errors == other.errors;

  @override
  int get hashCode => code.hashCode ^ errors.hashCode;
}

@immutable
final class AppException$TooManyRequests extends AppException$Base {
  final int? retryAfter;

  const AppException$TooManyRequests._(this.retryAfter);

  factory AppException$TooManyRequests.fromJson(JsonMap json) => AppException$TooManyRequests._(
        json['retry-after'] is! String ? null : int.tryParse(json['retry-after'] as String),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppException$TooManyRequests && runtimeType == other.runtimeType && retryAfter == other.retryAfter;

  @override
  int get hashCode => retryAfter.hashCode;
}

@immutable
final class AppException$UpdateRequired extends AppException$Base {
  const AppException$UpdateRequired({this.isOptional = false});

  /// Обязательно ли обновление приложения или рекомендация
  /// По умолчанию в false (отрабатывает на 426 ошибку)
  final bool isOptional;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppException$UpdateRequired && runtimeType == other.runtimeType && isOptional == other.isOptional;

  @override
  int get hashCode => isOptional.hashCode;
}

@immutable
final class AppException$Inputs extends AppException$Base {
  const AppException$Inputs._({required this.phone, required this.email, required this.code});

  final InputFieldExceptionData? phone;
  final InputFieldExceptionData? email;
  final InputFieldExceptionData? code;

  bool get isEmptyFields => [phone, email, code].every((e) => e == null);

  factory AppException$Inputs.fromJson(JsonMap json) {
    final inputs = json['errors'] as JsonList?;
    if (inputs == null) return const AppException$Inputs._(phone: null, email: null, code: null);

    final phoneJson = _findInStructuredData('phone', inputs);
    final emailJson = _findInStructuredData('email', inputs);
    final codeJson = _findInStructuredData('code', inputs);

    return AppException$Inputs._(
      phone: phoneJson == null ? null : InputFieldExceptionData.fromJson(phoneJson),
      email: emailJson == null ? null : InputFieldExceptionData.fromJson(emailJson),
      code: codeJson == null ? null : InputFieldExceptionData.fromJson(codeJson),
    );
  }

  static JsonMap? _findInStructuredData(String key, JsonList jsonList) {
    try {
      final castedList = jsonList.cast<JsonMap>();
      return castedList.firstWhereOrNull((e) => e['field'] == key);
    } on Object catch (_) {
      return null;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppException$Inputs &&
          runtimeType == other.runtimeType &&
          phone == other.phone &&
          email == other.email &&
          code == other.code;

  @override
  int get hashCode => Object.hash(phone, email, code);
}
