import '../repositories/converter_repository.dart';

/// Use case to convert speed values.
class ConvertSpeed {
  /// Creates [ConvertSpeed].
  const ConvertSpeed(this._repository);

  final ConverterRepository _repository;

  /// Converts [value] from [from] to [to].
  double call(double value, String from, String to) => _repository.convert(category: 'Speed', from: from, to: to, value: value);
}
