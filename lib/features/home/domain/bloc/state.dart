part of 'bloc.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.idle(HomeData? homeData) = HomeState$Idle;
  const factory HomeState.processing(HomeData? homeData) = HomeState$Processing;
  const factory HomeState.success(HomeData homeData) =
      HomeState$Success;
  const factory HomeState.error(HomeData? homeData, {required AppException$Base error}) = HomeState$Error;
}
