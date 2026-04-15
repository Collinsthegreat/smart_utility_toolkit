import 'package:equatable/equatable.dart';

/// Home state.
class HomeState extends Equatable {
  /// Creates [HomeState].
  const HomeState({required this.query, required this.tools});

  /// Search query.
  final String query;

  /// Filtered tools.
  final List<Map<String, dynamic>> tools;

  /// Returns copied state.
  HomeState copyWith({String? query, List<Map<String, dynamic>>? tools}) {
    return HomeState(query: query ?? this.query, tools: tools ?? this.tools);
  }

  @override
  List<Object?> get props => <Object?>[query, tools];
}

