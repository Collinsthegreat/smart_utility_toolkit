import 'package:equatable/equatable.dart';
import '../../domain/entities/bmi_result_entity.dart';

/// BMI state.
class BmiState extends Equatable {
  /// Creates [BmiState].
  const BmiState({required this.result, required this.history});
  final BmiResultEntity? result;
  final List<BmiResultEntity> history;
  BmiState copyWith({BmiResultEntity? result, List<BmiResultEntity>? history}) =>
      BmiState(result: result ?? this.result, history: history ?? this.history);
  @override
  List<Object?> get props => <Object?>[result, history];
}
