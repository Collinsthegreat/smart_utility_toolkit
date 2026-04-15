import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

/// Shared app bar component.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates [CustomAppBar].
  const CustomAppBar({required this.title, this.actions, super.key});

  /// App bar title.
  final String title;

  /// Optional action widgets.
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      elevation: 0,
      centerTitle: false,
      titleSpacing: AppSizes.md,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

