import '../repositories/converter_repository.dart';

/// Use case to convert area values.
class ConvertArea {
  /// Creates [ConvertArea].
  const ConvertArea(this._repository);

  final ConverterRepository _repository;

  /// Converts [value] from [from] to [to].
  double call(double value, String from, String to) => _repository.convert(category: 'Area', from: from, to: to, value: value);
}
