import '../repositories/converter_repository.dart';

/// Use case to convert length values.
class ConvertLength {
  /// Creates [ConvertLength].
  const ConvertLength(this._repository);

  final ConverterRepository _repository;

  /// Converts [value] from [from] to [to].
  double call(double value, String from, String to) => _repository.convert(category: 'Length', from: from, to: to, value: value);
}
