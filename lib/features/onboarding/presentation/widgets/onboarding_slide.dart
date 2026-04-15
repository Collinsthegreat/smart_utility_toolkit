import 'package:flutter/material.dart';

/// Single onboarding slide widget.
class OnboardingSlide extends StatelessWidget {
  /// Creates [OnboardingSlide].
  const OnboardingSlide({
    required this.title,
    required this.description,
    required this.icon,
    super.key,
  });

  /// Slide title.
  final String title;

  /// Slide description.
  final String description;

  /// Slide icon.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, size: 120),
        const SizedBox(height: 16),
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(description, textAlign: TextAlign.center),
      ],
    );
  }
}

