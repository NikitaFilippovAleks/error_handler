part of 'bloc.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.idle() = HomeState$Idle;
  const factory HomeState.processing() = HomeState$Processing;
  const factory HomeState.success() =
      HomeState$Success;
  const factory HomeState.error(AppException$Base error) = HomeState$Error;
}
