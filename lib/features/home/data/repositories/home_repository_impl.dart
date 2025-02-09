import 'package:error_handler/features/home/data/datasources/api.dart';
import 'package:error_handler/features/home/domain/repositories/home_repository.dart';
import 'package:error_handler/utils/client/index.dart';
import 'package:error_handler/utils/errors/app_exceptions.dart';

class HomeRepositoryImpl implements HomeRepository {
  Api api = Api();

  makeMain() {
    try {
      api.makeMain();
    } on RestClientException catch (e, s) {
      final appException = AppException$Base.fromRestClientException(e, s);
      Error.throwWithStackTrace(appException, s);
    }
  }

  makePhone() {
    api.makePhone();
  }

  makeEmail() {
    api.makeEmail();
  }
}
