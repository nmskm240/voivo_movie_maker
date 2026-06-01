import 'package:go_router/go_router.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/presentation/projects_list/screen.dart';
import 'package:voivo_movie_maker/presentation/project_edit/screen.dart';

final appRouter = GoRouter(
  initialLocation: ProjectListRoute.path,
  routes: [
    GoRoute(
      path: ProjectListRoute.path,
      name: ProjectListRoute.name,
      builder: (context, state) => const ProjectListScreen(),
      routes: [
        GoRoute(
          path: 'projects/:projectId',
          name: ProjectEditorRoute.name,
          builder: (context, state) {
            final projectId = ProjectId.fromString(
              state.pathParameters['projectId']!,
            );
            return EditorScreen(projectId: projectId);
          },
        ),
      ],
    ),
  ],
);

final class ProjectListRoute {
  const ProjectListRoute._();

  static const name = 'project-list';
  static const path = '/';
}

final class ProjectEditorRoute {
  const ProjectEditorRoute._();

  static const name = 'project-editor';

  static Map<String, String> params(ProjectId projectId) {
    return {'projectId': projectId.value};
  }
}
