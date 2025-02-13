import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_data.freezed.dart';

@freezed
class HomeData with _$HomeData {
  const factory HomeData({
    required String? mainData,
    required String? phoneData,
    required String? emailData,
  }) = _HomeData;

  const HomeData._();
}
