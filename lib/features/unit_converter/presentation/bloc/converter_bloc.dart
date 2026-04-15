import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/converter_local_datasource.dart';
import '../../domain/entities/conversion_entity.dart';
import '../../data/models/conversion_model.dart';
import '../../data/repositories/converter_repository_impl.dart';
import 'converter_event.dart';
import 'converter_state.dart';

/// BLoC for unit converter interactions.
class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  /// Creates [ConverterBloc].
  ConverterBloc(ConverterLocalDataSource local)
      : _repository = ConverterRepositoryImpl(local),
        super(const ConverterState(
          category: 'Length',
          from: 'm',
          to: 'km',
          input: '',
          output: '0',
          history: <ConversionEntity>[],
        )) {
    on<ConversionInputChanged>(_onInputChanged);
    on<ConversionCategoryChanged>(_onCategoryChanged);
    on<ConversionUnitChanged>(_onUnitChanged);
    on<ConversionHistoryRequested>(_onHistoryRequested);
  }

  final ConverterRepositoryImpl _repository;

  static const Map<String, List<String>> units = <String, List<String>>{
    'Length': <String>['m', 'km', 'cm', 'mi', 'ft'],
    'Weight': <String>['kg', 'g', 'lb', 'oz'],
    'Temperature': <String>['C', 'F', 'K'],
    'Currency': <String>['USD', 'NGN', 'EUR', 'GBP'],
    'Area': <String>['m²', 'km²', 'ft²', 'ac'],
    'Speed': <String>['m/s', 'km/h', 'mph', 'kn'],
  };

  void _onInputChanged(ConversionInputChanged event, Emitter<ConverterState> emit) {
    final double value = double.tryParse(event.value) ?? 0;
    final double result = _repository.convert(category: state.category, from: state.from, to: state.to, value: value);
    final ConversionModel conversion = ConversionModel(category: state.category, fromUnit: state.from, toUnit: state.to, input: value, output: result, timestamp: DateTime.now());
    _repository.saveConversion(conversion);
    final List<ConversionEntity> history = _repository.getHistory();
    emit(state.copyWith(input: event.value, output: result.toStringAsFixed(4), history: history, error: null));
  }

  void _onCategoryChanged(ConversionCategoryChanged event, Emitter<ConverterState> emit) {
    final List<String> catUnits = units[event.category] ?? <String>['m', 'km'];
    emit(state.copyWith(category: event.category, from: catUnits.first, to: catUnits.last, input: '', output: '0'));
    add(ConversionHistoryRequested());
  }

  void _onUnitChanged(ConversionUnitChanged event, Emitter<ConverterState> emit) {
    emit(state.copyWith(from: event.from, to: event.to));
    add(ConversionInputChanged(state.input));
  }

  void _onHistoryRequested(ConversionHistoryRequested event, Emitter<ConverterState> emit) {
    final List<ConversionEntity> history = _repository.getHistory();
    emit(state.copyWith(history: history));
  }
}
