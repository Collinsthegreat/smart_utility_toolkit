import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/usecases/calculate_expression.dart';
import 'calculator_event.dart';
import 'calculator_state.dart';

/// Calculator BLoC.
class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  /// Creates [CalculatorBloc].
  CalculatorBloc(
    this._calculateExpression, {
    Box<dynamic>? historyBox,
  })  : _historyBox = historyBox ?? Hive.box<dynamic>(AppConstants.calculatorHistoryBox),
        super(const CalculatorState(expression: '', result: '0', history: <String>[])) {
    on<CalculatorInputAdded>(_onInputAdded);
    on<CalculatorCleared>(_onCleared);
    on<CalculatorEvaluated>(_onEvaluated);
    on<CalculatorHistoryRequested>(_onHistoryRequested);
    add(const CalculatorHistoryRequested());
  }

  final CalculateExpression _calculateExpression;
  final Box<dynamic> _historyBox;

  void _onInputAdded(CalculatorInputAdded event, Emitter<CalculatorState> emit) {
    emit(state.copyWith(expression: state.expression + event.symbol));
  }

  void _onCleared(CalculatorCleared event, Emitter<CalculatorState> emit) {
    emit(const CalculatorState(expression: '', result: '0', history: <String>[]));
    add(const CalculatorHistoryRequested());
  }

  void _onEvaluated(CalculatorEvaluated event, Emitter<CalculatorState> emit) {
    final String result = _calculateExpression(state.expression).toStringAsFixed(2);
    _saveEntry('${state.expression.isEmpty ? '0' : state.expression} = $result');
    emit(state.copyWith(result: result, history: _loadHistory()));
  }

  void _onHistoryRequested(CalculatorHistoryRequested event, Emitter<CalculatorState> emit) {
    emit(state.copyWith(history: _loadHistory()));
  }

  void _saveEntry(String entry) {
    final List<dynamic> entries = _historyBox.get('history', defaultValue: <dynamic>[]) as List<dynamic>;
    final List<String> history = List<String>.from(entries);
    history.remove(entry);
    history.insert(0, entry);
    if (history.length > 10) {
      history.removeRange(10, history.length);
    }
    _historyBox.put('history', history);
  }

  List<String> _loadHistory() {
    final List<dynamic> entries = _historyBox.get('history', defaultValue: <dynamic>[]) as List<dynamic>;
    return List<String>.from(entries);
  }
}
