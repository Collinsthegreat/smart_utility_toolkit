import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../bloc/home_state.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/tool_card.dart';

/// Home dashboard page.
class HomePage extends StatelessWidget {
  /// Creates [HomePage].
  const HomePage({super.key});

  String _greeting() {
    final int hour = DateTime.now().hour;
    if (hour < 12) {
      return AppStrings.greetingMorning;
    }
    if (hour < 18) {
      return AppStrings.greetingAfternoon;
    }
    return AppStrings.greetingEvening;
  }

  @override
  Widget build(BuildContext context) {
    final Box<dynamic> settingsBox = Hive.box<dynamic>(AppConstants.settingsBox);
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.appName)),
        body: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _greeting(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.splashMessage,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  SearchBarWidget(
                    onChanged: (String value) =>
                        context.read<HomeBloc>().add(HomeSearchChanged(value)),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (BuildContext context, HomeState state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            ValueListenableBuilder<Box<dynamic>>(
                              valueListenable: settingsBox.listenable(keys: <String>['recent_tools']),
                              builder: (BuildContext context, Box<dynamic> box, Widget? child) {
                                final List<dynamic> recent = box.get('recent_tools', defaultValue: <dynamic>[]) as List<dynamic>;
                                if (recent.isEmpty) {
                                  return const SizedBox.shrink();
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Recently used', style: Theme.of(context).textTheme.titleMedium),
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      height: 140,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: recent.length,
                                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                                        itemBuilder: (BuildContext context, int index) {
                                          final String name = recent[index] as String;
                                          final Map<String, dynamic>? tool = state.tools.cast<Map<String, dynamic>?>().firstWhere(
                                            (Map<String, dynamic>? t) => t?['name'] == name,
                                            orElse: () => null,
                                          );
                                          if (tool == null) return const SizedBox.shrink();
                                          return SizedBox(
                                            width: 140,
                                            child: ToolCard(
                                              name: tool['name'] as String,
                                              description: tool['description'] as String,
                                              icon: tool['icon'] as IconData,
                                              onTap: () {
                                                final String route = tool['route'] as String;
                                                final List<String> updatedRecent = List<String>.from(box.get('recent_tools', defaultValue: <dynamic>[]) as List<dynamic>);
                                                updatedRecent.remove(name);
                                                updatedRecent.insert(0, name);
                                                if (updatedRecent.length > 5) {
                                                  updatedRecent.removeRange(5, updatedRecent.length);
                                                }
                                                box.put('recent_tools', updatedRecent);
                                                Navigator.of(context).pushNamed(route);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                );
                              },
                            ),
                            Expanded(
                              child: state.tools.isEmpty
                                  ? const Center(child: Text(AppStrings.noToolsFound))
                                  : GridView.builder(
                                      itemCount: state.tools.length,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        childAspectRatio: 1.05,
                                      ),
                                      itemBuilder: (_, int index) {
                                        final Map<String, dynamic> tool = state.tools[index];
                                        return ToolCard(
                                          name: tool['name'] as String,
                                          description: tool['description'] as String,
                                          icon: tool['icon'] as IconData,
                                          onTap: () {
                                            final String route = tool['route'] as String;
                                            final Box<dynamic> box = Hive.box<dynamic>(AppConstants.settingsBox);
                                            final List<String> recent = List<String>.from(box.get('recent_tools', defaultValue: <dynamic>[]) as List<dynamic>);
                                            recent.remove(tool['name'] as String);
                                            recent.insert(0, tool['name'] as String);
                                            if (recent.length > 5) {
                                              recent.removeRange(5, recent.length);
                                            }
                                            box.put('recent_tools', recent);
                                            Navigator.of(context).pushNamed(route);
                                          },
                                        );
                                      },
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

