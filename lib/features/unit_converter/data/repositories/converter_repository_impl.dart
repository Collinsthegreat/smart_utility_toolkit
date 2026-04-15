import '../../../../core/utils/conversion_utils.dart';
import '../../domain/entities/conversion_entity.dart';
import '../../domain/repositories/converter_repository.dart';
import '../datasources/converter_local_datasource.dart';
import '../models/conversion_model.dart';

/// Converter repository implementation.
class ConverterRepositoryImpl implements ConverterRepository {
  /// Creates [ConverterRepositoryImpl].
  ConverterRepositoryImpl(this._local);

  final ConverterLocalDataSource _local;

  static const Map<String, double> _lengthMeters = <String, double>{'m': 1, 'km': 1000, 'cm': 0.01, 'mi': 1609.344, 'ft': 0.3048};
  static const Map<String, double> _weightKg = <String, double>{'kg': 1, 'g': 0.001, 'lb': 0.45359237, 'oz': 0.0283495231};
  static const Map<String, double> _areaSqm = <String, double>{'m²': 1, 'km²': 1000000, 'ft²': 0.092903, 'ac': 4046.8564224};
  static const Map<String, double> _speedMps = <String, double>{'m/s': 1, 'km/h': 0.277777778, 'mph': 0.44704, 'kn': 0.514444};
  static const Map<String, double> _currency = <String, double>{'USD': 1, 'NGN': 1550, 'EUR': 0.92, 'GBP': 0.78};

  @override
  double convert({required String category, required String from, required String to, required double value}) {
    if (from == to) return value;
    switch (category) {
      case 'Length':
        return value * (_lengthMeters[from]! / _lengthMeters[to]!);
      case 'Weight':
        return value * (_weightKg[from]! / _weightKg[to]!);
      case 'Area':
        return value * (_areaSqm[from]! / _areaSqm[to]!);
      case 'Speed':
        return value * (_speedMps[from]! / _speedMps[to]!);
      case 'Currency':
        return value * (_currency[to]! / _currency[from]!);
      case 'Temperature':
        final double c = ConversionUtils.toCelsius(value, from);
        return ConversionUtils.fromCelsius(c, to);
      default:
        return value;
    }
  }

  @override
  List<ConversionEntity> getHistory() => _local.getHistory().cast<ConversionEntity>();

  @override
  Future<void> saveConversion(ConversionEntity conversion) {
    return _local.saveConversion(ConversionModel(
      category: conversion.category,
      fromUnit: conversion.fromUnit,
      toUnit: conversion.toUnit,
      input: conversion.input,
      output: conversion.output,
      timestamp: conversion.timestamp,
    ));
  }
}
