import '../repositories/converter_repository.dart';

/// Use case to convert weight values.
class ConvertWeight {
  /// Creates [ConvertWeight].
  const ConvertWeight(this._repository);

  final ConverterRepository _repository;

  /// Converts [value] from [from] to [to].
  double call(double value, String from, String to) => _repository.convert(category: 'Weight', from: from, to: to, value: value);
}
