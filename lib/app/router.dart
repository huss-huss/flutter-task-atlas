import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskatlas_flutter/features/home/presentation/pages/home_page.dart';
import 'package:taskatlas_flutter/features/tasks/presentation/pages/tasks_page.dart';
import 'package:taskatlas_flutter/features/tasks/presentation/pages/create_task_page.dart';
import 'package:taskatlas_flutter/features/notes/presentation/pages/notes_page.dart';
import 'package:taskatlas_flutter/features/habits/presentation/pages/habits_page.dart';
import 'package:taskatlas_flutter/features/profile/presentation/pages/profile_page.dart';
import 'package:taskatlas_flutter/features/tasks/presentation/pages/task_detail_page.dart';
import 'package:taskatlas_flutter/features/notes/presentation/pages/note_detail_page.dart';

class AppRouter {
  static const String home = '/';
  static const String tasks = '/tasks';
  static const String notes = '/notes';
  static const String habits = '/habits';
  static const String profile = '/profile';
  static const String createTask = '/tasks/new';
  static const String taskDetail = '/task/:id';
  static const String noteDetail = '/note/:id';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const MainScaffold(
          currentIndex: 0,
          child: HomePage(),
        ),
      ),
      GoRoute(
        path: tasks,
        builder: (context, state) => const MainScaffold(
          currentIndex: 1,
          child: TasksPage(),
        ),
        routes: [
          GoRoute(
            path: 'new',
            builder: (context, state) => const CreateTaskPage(),
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final taskId = state.pathParameters['id']!;
              return TaskDetailPage(taskId: taskId);
            },
          ),
        ],
      ),
      GoRoute(
        path: notes,
        builder: (context, state) => const MainScaffold(
          currentIndex: 2,
          child: NotesPage(),
        ),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final noteId = state.pathParameters['id']!;
              return NoteDetailPage(noteId: noteId);
            },
          ),
        ],
      ),
      GoRoute(
        path: habits,
        builder: (context, state) => const MainScaffold(
          currentIndex: 3,
          child: HabitsPage(),
        ),
      ),
      GoRoute(
        path: profile,
        builder: (context, state) => const MainScaffold(
          currentIndex: 4,
          child: ProfilePage(),
        ),
      ),
    ],
  );
}

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.currentIndex,
    required this.child,
  });

  final int currentIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          final routes = ['/', '/tasks', '/notes', '/habits', '/profile'];
          context.go(routes[index]);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_outlined),
            selectedIcon: Icon(Icons.task),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.note_outlined),
            selectedIcon: Icon(Icons.note),
            label: 'Notes',
          ),
          NavigationDestination(
            icon: Icon(Icons.repeat_outlined),
            selectedIcon: Icon(Icons.repeat),
            label: 'Habits',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
