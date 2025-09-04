import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskatlas_flutter/core/models/task.dart';
import 'package:taskatlas_flutter/core/models/note.dart';
import 'package:taskatlas_flutter/core/models/habit.dart';

// Enhanced mock data with more realistic scenarios
final List<Task> _mockTasks = [
  Task(
    id: '1',
    title: 'Complete Flutter project setup',
    dueAt: DateTime.now().add(const Duration(days: 1)),
    isDone: false,
    tags: ['work', 'flutter', 'development'],
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Task(
    id: '2',
    title: 'Learn Riverpod state management',
    dueAt: DateTime.now().add(const Duration(days: 2)),
    isDone: false,
    tags: ['learning', 'flutter', 'state-management'],
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Task(
    id: '3',
    title: 'Implement offline-first architecture',
    dueAt: DateTime.now().add(const Duration(days: 3)),
    isDone: true,
    tags: ['architecture', 'offline', 'completed'],
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    updatedAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
  Task(
    id: '4',
    title: 'Design user interface mockups',
    dueAt: DateTime.now().add(const Duration(hours: 6)),
    isDone: false,
    tags: ['design', 'ui', 'ux'],
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  Task(
    id: '5',
    title: 'Write unit tests',
    dueAt: DateTime.now().add(const Duration(days: 1)),
    isDone: false,
    tags: ['testing', 'quality', 'development'],
    createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 4)),
  ),
];

final List<Note> _mockNotes = [
  Note(
    id: '1',
    title: 'Flutter Best Practices',
    content:
        'Always use const constructors when possible, implement proper error handling, and follow Material Design guidelines.',
    tags: ['flutter', 'best-practices', 'development'],
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Note(
    id: '2',
    title: 'Project Ideas',
    content:
        '1. Task management app\n2. Recipe finder\n3. Fitness tracker\n4. Learning platform\n5. Social media app',
    tags: ['ideas', 'planning', 'projects'],
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
];

final List<Habit> _mockHabits = [
  Habit(
    id: '1',
    name: 'Morning Exercise',
    cadence: HabitCadence.daily,
    streak: 7,
    lastTickAt: DateTime.now().subtract(const Duration(days: 1)),
    createdAt: DateTime.now().subtract(const Duration(days: 10)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Habit(
    id: '2',
    name: 'Read 30 minutes',
    cadence: HabitCadence.daily,
    streak: 12,
    lastTickAt: DateTime.now(),
    createdAt: DateTime.now().subtract(const Duration(days: 15)),
    updatedAt: DateTime.now(),
  ),
  Habit(
    id: '3',
    name: 'Drink Water',
    cadence: HabitCadence.daily,
    streak: 3,
    lastTickAt: DateTime.now().subtract(const Duration(days: 2)),
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Habit(
    id: '4',
    name: 'Weekly Planning',
    cadence: HabitCadence.weekly,
    streak: 4,
    lastTickAt: DateTime.now().subtract(const Duration(days: 3)),
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    updatedAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
];

// Task Providers
final allTasksProvider = StreamProvider<List<Task>>((ref) {
  return Stream.value(_mockTasks);
});

final pendingTasksProvider = StreamProvider<List<Task>>((ref) {
  final tasks = _mockTasks.where((task) => !task.isDone).toList();
  return Stream.value(tasks);
});

final completedTasksProvider = StreamProvider<List<Task>>((ref) {
  final tasks = _mockTasks.where((task) => task.isDone).toList();
  return Stream.value(tasks);
});

final todayTasksProvider = StreamProvider<List<Task>>((ref) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tasks = _mockTasks.where((task) {
    if (task.dueAt == null) return false;
    final dueDate =
        DateTime(task.dueAt!.year, task.dueAt!.month, task.dueAt!.day);
    return dueDate == today;
  }).toList();
  return Stream.value(tasks);
});

final overdueTasksProvider = StreamProvider<List<Task>>((ref) {
  final now = DateTime.now();
  final tasks = _mockTasks.where((task) {
    if (task.dueAt == null || task.isDone) return false;
    return task.dueAt!.isBefore(now);
  }).toList();
  return Stream.value(tasks);
});

final upcomingTasksProvider = StreamProvider<List<Task>>((ref) {
  final now = DateTime.now();
  final tasks = _mockTasks.where((task) {
    if (task.dueAt == null || task.isDone) return false;
    return task.dueAt!.isAfter(now);
  }).toList();
  return Stream.value(tasks);
});

// Note Providers
final allNotesProvider = StreamProvider<List<Note>>((ref) {
  return Stream.value(_mockNotes);
});

final notesByTagProvider =
    StreamProvider.family<List<Note>, String>((ref, tag) {
  final notes = _mockNotes.where((note) => note.tags.contains(tag)).toList();
  return Stream.value(notes);
});

// Habit Providers
final allHabitsProvider = StreamProvider<List<Habit>>((ref) {
  return Stream.value(_mockHabits);
});

final habitsByCadenceProvider =
    StreamProvider.family<List<Habit>, HabitCadence>((ref, cadence) {
  final habits =
      _mockHabits.where((habit) => habit.cadence == cadence).toList();
  return Stream.value(habits);
});

final activeHabitsProvider = StreamProvider<List<Habit>>((ref) {
  final now = DateTime.now();
  final habits = _mockHabits.where((habit) {
    if (habit.lastTickAt == null) return true;
    final daysSinceLastTick = now.difference(habit.lastTickAt!).inDays;

    switch (habit.cadence) {
      case HabitCadence.daily:
        return daysSinceLastTick >= 1;
      case HabitCadence.weekly:
        return daysSinceLastTick >= 7;
      case HabitCadence.monthly:
        return daysSinceLastTick >= 30;
    }
  }).toList();
  return Stream.value(habits);
});

// Statistics Providers
final taskStatisticsProvider = StreamProvider<Map<String, dynamic>>((ref) {
  final tasks = _mockTasks;
  final total = tasks.length;
  final completed = tasks.where((t) => t.isDone).length;
  final pending = total - completed;
  final overdue = tasks
      .where((t) =>
          t.dueAt != null && !t.isDone && t.dueAt!.isBefore(DateTime.now()))
      .length;

  return Stream.value({
    'total': total,
    'completed': completed,
    'pending': pending,
    'overdue': overdue,
    'completionRate': total > 0 ? (completed / total * 100).round() : 0,
  });
});

final habitStatisticsProvider = StreamProvider<Map<String, dynamic>>((ref) {
  final habits = _mockHabits;
  final total = habits.length;
  final totalStreak = habits.fold<int>(0, (sum, habit) => sum + habit.streak);
  final averageStreak = total > 0 ? (totalStreak / total).round() : 0;

  return Stream.value({
    'total': total,
    'totalStreak': totalStreak,
    'averageStreak': averageStreak,
    'longestStreak': habits.isNotEmpty
        ? habits.map((h) => h.streak).reduce((a, b) => a > b ? a : b)
        : 0,
  });
});
