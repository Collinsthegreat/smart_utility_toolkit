import 'package:equatable/equatable.dart';

/// BMI result entity.
class BmiResultEntity extends Equatable {
  /// Creates [BmiResultEntity].
  const BmiResultEntity({required this.value, required this.category, required this.tip});
  final double value;
  final String category;
  final String tip;
  @override
  List<Object?> get props => <Object?>[value, category, tip];
}
