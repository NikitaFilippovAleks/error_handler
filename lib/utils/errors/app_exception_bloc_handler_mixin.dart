import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_exceptions.dart';

mixin AppExceptionsHandlerMixin<Event, State> on Bloc<Event, State> {
  Future<void> handleAppException({
    required Future<void> Function() method,
    required void Function(AppException$Base error) onError,
    void Function()? onFinally,
  }) async {
    try {
      await method.call();
    } on AppException$Base catch (e, s) {
      onError.call(e);
      debugPrintStack(stackTrace: s);
    } on Object catch (e, s) {
      onError.call(const AppException$Simple());
      this.onError(e, s);
    } finally {
      onFinally?.call();
    }
  }
}
