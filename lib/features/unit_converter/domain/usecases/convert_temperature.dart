import '../repositories/converter_repository.dart';

/// Use case to convert temperature values.
class ConvertTemperature {
  /// Creates [ConvertTemperature].
  const ConvertTemperature(this._repository);

  final ConverterRepository _repository;

  /// Converts [value] from [from] to [to].
  double call(double value, String from, String to) => _repository.convert(category: 'Temperature', from: from, to: to, value: value);
}
