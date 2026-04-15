import '../entities/conversion_entity.dart';

/// Repository contract for conversion operations.
abstract class ConverterRepository {
  /// Performs conversion.
  double convert({required String category, required String from, required String to, required double value});

  /// Persists conversion in local history.
  Future<void> saveConversion(ConversionEntity conversion);

  /// Gets latest conversion history.
  List<ConversionEntity> getHistory();
}
