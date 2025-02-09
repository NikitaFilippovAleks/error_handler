import 'package:error_handler/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../utils/errors/app_exception_bloc_handler_mixin.dart';
import '../../../../../utils/errors/app_exceptions.dart';

part 'event.dart';
part 'state.dart';
part 'bloc.freezed.dart';

typedef _Emitter = Emitter<HomeState>;

class HomeBloc extends Bloc<HomeEvent, HomeState>
    with AppExceptionsHandlerMixin {
  HomeBloc(this.homeRepository, super.initialState) {
    on<HomeEvent>(
      (event, emitter) => switch (event) {
        _MakeMain() => _makeMain(event, emitter),
        _MakePhone() => _makePhone(event, emitter),
        _MakeEmail() => _makeEmail(event, emitter),
      },
    );
  }

  HomeRepository homeRepository;

  Future<void> _makeMain(_MakeMain event, _Emitter emitter) async {
    homeRepository.makeMain();
  }

  Future<void> _makePhone(_MakePhone event, _Emitter emitter) async {
    homeRepository.makePhone();
  }

  Future<void> _makeEmail(_MakeEmail event, _Emitter emitter) async {
    homeRepository.makeEmail();
  }
}
