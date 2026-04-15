import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

/// Home BLoC for dashboard filtering.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// Creates [HomeBloc].
  HomeBloc()
      : _allTools = const <Map<String, dynamic>>[
          <String, dynamic>{
            'name': 'Unit Converter',
            'description': 'Convert between units quickly',
            'route': '/unit-converter',
            'icon': Icons.swap_horiz,
          },
          <String, dynamic>{
            'name': 'Calculator',
            'description': 'Evaluate expressions with ease',
            'route': '/calculator',
            'icon': Icons.calculate,
          },
          <String, dynamic>{
            'name': 'BMI Calculator',
            'description': 'Check your health index',
            'route': '/bmi',
            'icon': Icons.favorite,
          },
          <String, dynamic>{
            'name': 'Bill Splitter',
            'description': 'Split bills with tips',
            'route': '/bill-splitter',
            'icon': Icons.receipt_long,
          },
        ],
        super(const HomeState(query: '', tools: <Map<String, dynamic>>[])) {
    on<HomeSearchChanged>(_onSearchChanged);
    add(const HomeSearchChanged(''));
  }

  final List<Map<String, dynamic>> _allTools;

  void _onSearchChanged(HomeSearchChanged event, Emitter<HomeState> emit) {
    final String normalized = event.query.toLowerCase();
    final List<Map<String, dynamic>> filtered = _allTools
        .where((Map<String, dynamic> tool) =>
            (tool['name'] as String).toLowerCase().contains(normalized))
        .toList();
    emit(state.copyWith(query: event.query, tools: filtered));
  }
}

