// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeData {
  String? get mainData => throw _privateConstructorUsedError;
  String? get phoneData => throw _privateConstructorUsedError;
  String? get emailData => throw _privateConstructorUsedError;

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeDataCopyWith<HomeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeDataCopyWith<$Res> {
  factory $HomeDataCopyWith(HomeData value, $Res Function(HomeData) then) =
      _$HomeDataCopyWithImpl<$Res, HomeData>;
  @useResult
  $Res call({String? mainData, String? phoneData, String? emailData});
}

/// @nodoc
class _$HomeDataCopyWithImpl<$Res, $Val extends HomeData>
    implements $HomeDataCopyWith<$Res> {
  _$HomeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainData = freezed,
    Object? phoneData = freezed,
    Object? emailData = freezed,
  }) {
    return _then(_value.copyWith(
      mainData: freezed == mainData
          ? _value.mainData
          : mainData // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneData: freezed == phoneData
          ? _value.phoneData
          : phoneData // ignore: cast_nullable_to_non_nullable
              as String?,
      emailData: freezed == emailData
          ? _value.emailData
          : emailData // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeDataImplCopyWith<$Res>
    implements $HomeDataCopyWith<$Res> {
  factory _$$HomeDataImplCopyWith(
          _$HomeDataImpl value, $Res Function(_$HomeDataImpl) then) =
      __$$HomeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? mainData, String? phoneData, String? emailData});
}

/// @nodoc
class __$$HomeDataImplCopyWithImpl<$Res>
    extends _$HomeDataCopyWithImpl<$Res, _$HomeDataImpl>
    implements _$$HomeDataImplCopyWith<$Res> {
  __$$HomeDataImplCopyWithImpl(
      _$HomeDataImpl _value, $Res Function(_$HomeDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainData = freezed,
    Object? phoneData = freezed,
    Object? emailData = freezed,
  }) {
    return _then(_$HomeDataImpl(
      mainData: freezed == mainData
          ? _value.mainData
          : mainData // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneData: freezed == phoneData
          ? _value.phoneData
          : phoneData // ignore: cast_nullable_to_non_nullable
              as String?,
      emailData: freezed == emailData
          ? _value.emailData
          : emailData // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$HomeDataImpl extends _HomeData {
  const _$HomeDataImpl(
      {required this.mainData,
      required this.phoneData,
      required this.emailData})
      : super._();

  @override
  final String? mainData;
  @override
  final String? phoneData;
  @override
  final String? emailData;

  @override
  String toString() {
    return 'HomeData(mainData: $mainData, phoneData: $phoneData, emailData: $emailData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeDataImpl &&
            (identical(other.mainData, mainData) ||
                other.mainData == mainData) &&
            (identical(other.phoneData, phoneData) ||
                other.phoneData == phoneData) &&
            (identical(other.emailData, emailData) ||
                other.emailData == emailData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mainData, phoneData, emailData);

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeDataImplCopyWith<_$HomeDataImpl> get copyWith =>
      __$$HomeDataImplCopyWithImpl<_$HomeDataImpl>(this, _$identity);
}

abstract class _HomeData extends HomeData {
  const factory _HomeData(
      {required final String? mainData,
      required final String? phoneData,
      required final String? emailData}) = _$HomeDataImpl;
  const _HomeData._() : super._();

  @override
  String? get mainData;
  @override
  String? get phoneData;
  @override
  String? get emailData;

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeDataImplCopyWith<_$HomeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
