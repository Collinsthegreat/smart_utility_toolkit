import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/bmi_result_entity.dart';
import '../../domain/usecases/calculate_bmi.dart';
import 'bmi_event.dart';
import 'bmi_state.dart';

/// BMI BLoC.
class BmiBloc extends Bloc<BmiEvent, BmiState> {
  /// Creates [BmiBloc].
  BmiBloc(
    this._calculateBmi, {
    Box<dynamic>? historyBox,
  })  : _historyBox = historyBox ?? Hive.box<dynamic>(AppConstants.bmiHistoryBox),
        super(const BmiState(result: null, history: <BmiResultEntity>[])) {
    on<BmiCalculated>(_onCalculated);
    on<BmiHistoryRequested>(_onHistoryRequested);
    add(const BmiHistoryRequested());
  }

  final CalculateBmi _calculateBmi;
  final Box<dynamic> _historyBox;

  void _onCalculated(BmiCalculated event, Emitter<BmiState> emit) {
    final BmiResultEntity result = _calculateBmi(height: event.height, weight: event.weight, isImperial: event.isImperial);
    _saveHistory(result);
    emit(state.copyWith(result: result, history: _loadHistory()));
  }

  void _onHistoryRequested(BmiHistoryRequested event, Emitter<BmiState> emit) {
    emit(state.copyWith(history: _loadHistory()));
  }

  void _saveHistory(BmiResultEntity result) {
    final List<dynamic> saved = _historyBox.get('history', defaultValue: <dynamic>[]) as List<dynamic>;
    final List<Map<String, dynamic>> history = saved
        .map((dynamic item) => Map<String, dynamic>.from(item as Map<dynamic, dynamic>))
        .toList();
    history.insert(
      0,
      <String, dynamic>{
        'value': result.value,
        'category': result.category,
        'tip': result.tip,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
    if (history.length > 5) {
      history.removeRange(5, history.length);
    }
    _historyBox.put('history', history);
  }

  List<BmiResultEntity> _loadHistory() {
    final List<dynamic> saved = _historyBox.get('history', defaultValue: <dynamic>[]) as List<dynamic>;
    return saved
        .map((dynamic item) {
          final Map<String, dynamic> json = Map<String, dynamic>.from(item as Map);
          return BmiResultEntity(
            value: (json['value'] as num).toDouble(),
            category: json['category'] as String,
            tip: json['tip'] as String,
          );
        })
        .toList();
  }
}
