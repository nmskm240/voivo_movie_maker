// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/project_summary.dart';
import 'package:voivo_movie_maker/application/usecases.dart';
import 'package:voivo_movie_maker/presentation/projects_list/widgets/new_project_dialog.dart';
import 'package:voivo_movie_maker/presentation/router.dart';

class ProjectListScreen extends ConsumerWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: SafeArea(
        child: ref
            .watch(fetchProjectSummariesProvider)
            .when(
              data: (items) {
                if (items.isEmpty) {
                  return const Center(child: Text('No projects yet'));
                }

                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final project = items[index];
                    return ListTile(
                      title: Text(project.name),
                      onTap: () => context.goNamed(
                        ProjectEditorRoute.name,
                        pathParameters: ProjectEditorRoute.params(project.id),
                      ),
                      onLongPress: () => _deleteProject(context, ref, project),
                    );
                  },
                );
              },
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createProject(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _createProject(BuildContext context, WidgetRef ref) async {
    final name = await NewProjectDialog.show(context);
    if (name == null) {
      return;
    }

    final projectId = await ref.read(
      createProjectProvider.call(name: name).future,
    );
    if (!context.mounted) {
      return;
    }

    context.goNamed(
      ProjectEditorRoute.name,
      pathParameters: ProjectEditorRoute.params(projectId),
    );
  }

  Future<void> _deleteProject(
    BuildContext context,
    WidgetRef ref,
    ProjectSummary project,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete project?'),
        content: Text(
          '"${project.name}" and all of its assets will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      return;
    }

    try {
      await ref.read(deleteProjectProvider(project.id).future);
      ref.invalidate(fetchProjectSummariesProvider);
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not delete project: $error')),
      );
    }
  }
}
