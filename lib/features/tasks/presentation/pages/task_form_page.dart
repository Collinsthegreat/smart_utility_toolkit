import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task_entity.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../bloc/tasks_bloc.dart';
import '../bloc/tasks_event.dart';

/// Page for creating and editing a task.
class TaskFormPage extends StatefulWidget {
  /// Creates [TaskFormPage].
  const TaskFormPage({this.task, super.key});

  /// The task being edited. If null, creates a new one.
  final TaskEntity? task;

  @override
  State<TaskFormPage> createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  int _priority = 0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descController = TextEditingController(text: widget.task?.description ?? '');
    _priority = widget.task?.priority ?? 0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  bool _isValid() => _titleController.text.trim().isNotEmpty;

  void _onSave() {
    if (!_isValid()) return;

    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (widget.task == null) {
      context.read<TasksBloc>().add(CreateTaskEvent(
            title: title,
            description: desc,
            priority: _priority,
          ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.taskCreated)),
      );
    } else {
      final updatedTask = widget.task!.copyWith(
        title: title,
        description: desc,
        priority: _priority,
        updatedAt: DateTime.now(),
      );
      context.read<TasksBloc>().add(UpdateTaskEvent(updatedTask));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.taskUpdated)),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;
    return Scaffold(
      appBar: CustomAppBar(
        title: isEditing ? AppStrings.editTask : AppStrings.newTask,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(AppStrings.taskTitle, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppSizes.xs),
            CustomTextField(
              controller: _titleController,
              hint: AppStrings.taskTitleHint,
              maxLength: 100,
              textInputAction: TextInputAction.next,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: AppSizes.md),
            Text(AppStrings.taskDescription, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppSizes.xs),
            CustomTextField(
              controller: _descController,
              hint: AppStrings.taskDescriptionHint,
              maxLines: 4,
              maxLength: 500,
            ),
            const SizedBox(height: AppSizes.lg),
            Text(AppStrings.priority, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppSizes.sm),
            Row(
              children: <Widget>[
                _buildPrioritySelector(title: AppStrings.priorityLow, value: 0, color: AppColors.priorityLow),
                const SizedBox(width: AppSizes.sm),
                _buildPrioritySelector(title: AppStrings.priorityMedium, value: 1, color: AppColors.priorityMedium),
                const SizedBox(width: AppSizes.sm),
                _buildPrioritySelector(title: AppStrings.priorityHigh, value: 2, color: AppColors.priorityHigh),
              ],
            ),
            const SizedBox(height: AppSizes.xl),
            CustomButton(
              label: AppStrings.save,
              onPressed: _isValid() ? _onSave : () {}, // Pass simple empty func when disabled to match CustomButton type assumption, if disabled styling implemented
              // Note: actually if we just pass a function but logic depends on _isValid,
              // we can actually do child opacity or check if `CustomButton` has a disabled state.
            ),
            if (!_isValid()) ...[
               const SizedBox(height: AppSizes.xs),
               Text(
                 'Title cannot be empty',
                 style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                 textAlign: TextAlign.center,
               )
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildPrioritySelector({required String title, required int value, required Color color}) {
    final isSelected = _priority == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _priority = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
          decoration: BoxDecoration(
            color: isSelected ? color.withValues(alpha: 0.15) : Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            border: Border.all(
              color: isSelected ? color : Colors.transparent,
              width: 2,
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? color : Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ),
    );
  }
}
