part of 'bloc.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.makeMain() = _MakeMain;
  const factory HomeEvent.makePhone() = _MakePhone;
  const factory HomeEvent.makeEmail() = _MakeEmail;
}
