import '../repositories/converter_repository.dart';

/// Use case to convert currency values.
class ConvertCurrency {
  /// Creates [ConvertCurrency].
  const ConvertCurrency(this._repository);

  final ConverterRepository _repository;

  /// Converts [value] from [from] to [to].
  double call(double value, String from, String to) => _repository.convert(category: 'Currency', from: from, to: to, value: value);
}
