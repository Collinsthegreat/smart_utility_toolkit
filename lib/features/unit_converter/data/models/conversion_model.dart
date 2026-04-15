import '../../domain/entities/conversion_entity.dart';

/// Conversion model for local storage.
class ConversionModel extends ConversionEntity {
  /// Creates [ConversionModel].
  const ConversionModel({
    required super.category,
    required super.fromUnit,
    required super.toUnit,
    required super.input,
    required super.output,
    required super.timestamp,
  });

  /// Creates model from JSON.
  factory ConversionModel.fromJson(Map<String, dynamic> json) {
    return ConversionModel(
      category: json['category'] as String,
      fromUnit: json['fromUnit'] as String,
      toUnit: json['toUnit'] as String,
      input: (json['input'] as num).toDouble(),
      output: (json['output'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  /// Converts model to JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'category': category,
        'fromUnit': fromUnit,
        'toUnit': toUnit,
        'input': input,
        'output': output,
        'timestamp': timestamp.toIso8601String(),
      };
}
