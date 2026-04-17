import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../bloc/onboarding_bloc.dart';
import '../../bloc/onboarding_event.dart';
import '../../bloc/onboarding_state.dart';
import '../widgets/onboarding_slide.dart';

/// Onboarding page with three slides.
class OnboardingPage extends StatefulWidget {
  /// Creates [OnboardingPage].
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    await Hive.box<dynamic>(AppConstants.settingsBox)
        .put(AppConstants.onboardingCompleteKey, true);
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingBloc>(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (BuildContext context, OnboardingState state) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int index) => context
                        .read<OnboardingBloc>()
                        .add(OnboardingPageChanged(index)),
                    children: const <Widget>[
                      OnboardingSlide(
                        title: AppStrings.onboardingOne,
                        description: 'Access every daily utility in one app.',
                        icon: Icons.dashboard_customize_outlined,
                      ),
                      OnboardingSlide(
                        title: AppStrings.onboardingTwo,
                        description: 'Fast and accurate unit conversions.',
                        icon: Icons.swap_horiz_outlined,
                      ),
                      OnboardingSlide(
                        title: AppStrings.onboardingThree,
                        description: 'Capture and manage notes with ease.',
                        icon: Icons.note_alt_outlined,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                          3,
                          (int index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: state.pageIndex == index ? 24 : 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: state.pageIndex == index
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                            onPressed: _completeOnboarding,
                            child: const Text(AppStrings.skip),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (state.pageIndex < 2) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                await _completeOnboarding();
                              }
                            },
                            child: Text(state.pageIndex < 2 ? AppStrings.next : AppStrings.getStarted),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

