import '../typedefs.dart';

enum InputExceptionType {
  invalidField,
  mustBeUnique,
  other;

  factory InputExceptionType.fromCode(String? code) => switch (code) {
        'invalid_field' => InputExceptionType.invalidField,
        'must_be_unique' => InputExceptionType.mustBeUnique,
        _ => InputExceptionType.other,
      };
}

final class InputFieldExceptionData {
  final String field;
  final String message;
  final InputExceptionType type;

  const InputFieldExceptionData({
    required this.field,
    required this.message,
    required this.type,
  });

  factory InputFieldExceptionData.fromJson(JsonMap json) => InputFieldExceptionData(
        field: json['field'].toString(),
        message: json['message'].toString(),
        type: InputExceptionType.fromCode(json['code'].toString()),
      );
}
