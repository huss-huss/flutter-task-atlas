import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HabitsPage extends ConsumerWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddHabitDialog(context),
          ),
        ],
      ),
      body: _buildHabitsList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHabitDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildHabitsList(BuildContext context) {
    // TODO: Replace with actual habits data from provider
    final habits = [
      _MockHabit(
        id: '1',
        name: 'Morning Exercise',
        cadence: 'Daily',
        streak: 7,
        lastTickAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      _MockHabit(
        id: '2',
        name: 'Read 30 minutes',
        cadence: 'Daily',
        streak: 12,
        lastTickAt: DateTime.now(),
      ),
      _MockHabit(
        id: '3',
        name: 'Drink Water',
        cadence: 'Daily',
        streak: 3,
        lastTickAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];

    if (habits.isEmpty) {
              return _buildEmptyState(context);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: habits.length,
      itemBuilder: (context, index) {
        return _buildHabitCard(context, habits[index]);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.repeat, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No habits yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start building positive habits to improve your life',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showAddHabitDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Add First Habit'),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitCard(BuildContext context, _MockHabit habit) {
    final canTick = _canTickHabit(habit);
    final daysSinceLastTick = _getDaysSinceLastTick(habit.lastTickAt);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        habit.cadence,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStreakBadge(context, habit.streak),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildProgressIndicator(context, habit, daysSinceLastTick),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: canTick ? () => _tickHabit(context, habit) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: canTick ? Colors.green : Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(canTick ? 'Tick' : 'Done'),
                ),
              ],
            ),
            if (daysSinceLastTick > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Last ticked: ${_formatDaysAgo(daysSinceLastTick)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: daysSinceLastTick > 3 ? Colors.orange : Colors.grey[600],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakBadge(BuildContext context, int streak) {
    Color badgeColor;
    if (streak >= 30) {
      badgeColor = Colors.purple;
    } else if (streak >= 21) {
      badgeColor = Colors.blue;
    } else if (streak >= 7) {
      badgeColor = Colors.green;
    } else {
      badgeColor = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '$streak day${streak == 1 ? '' : 's'}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, _MockHabit habit, int daysSinceLastTick) {
    final progress = _calculateProgress(habit, daysSinceLastTick);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '${(progress * 100).round()}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            progress >= 0.8 ? Colors.green : 
            progress >= 0.5 ? Colors.orange : Colors.red,
          ),
        ),
      ],
    );
  }

  double _calculateProgress(_MockHabit habit, int daysSinceLastTick) {
    // Simple progress calculation based on cadence and last tick
    switch (habit.cadence.toLowerCase()) {
      case 'daily':
        return daysSinceLastTick == 0 ? 1.0 : 
               daysSinceLastTick == 1 ? 0.8 : 
               daysSinceLastTick == 2 ? 0.5 : 0.0;
      case 'weekly':
        return daysSinceLastTick <= 1 ? 1.0 : 
               daysSinceLastTick <= 3 ? 0.6 : 
               daysSinceLastTick <= 7 ? 0.3 : 0.0;
      case 'monthly':
        return daysSinceLastTick <= 3 ? 1.0 : 
               daysSinceLastTick <= 10 ? 0.7 : 
               daysSinceLastTick <= 20 ? 0.4 : 0.0;
      default:
        return 0.0;
    }
  }

  bool _canTickHabit(_MockHabit habit) {
    final daysSinceLastTick = _getDaysSinceLastTick(habit.lastTickAt);
    
    switch (habit.cadence.toLowerCase()) {
      case 'daily':
        return daysSinceLastTick >= 1;
      case 'weekly':
        return daysSinceLastTick >= 7;
      case 'monthly':
        return daysSinceLastTick >= 30;
      default:
        return false;
    }
  }

  int _getDaysSinceLastTick(DateTime? lastTickAt) {
    if (lastTickAt == null) return 999; // Never ticked
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastTick = DateTime(lastTickAt.year, lastTickAt.month, lastTickAt.day);
    
    return today.difference(lastTick).inDays;
  }

  String _formatDaysAgo(int days) {
    if (days == 1) return 'Yesterday';
    if (days == 0) return 'Today';
    return '$days days ago';
  }

  void _tickHabit(BuildContext context, _MockHabit habit) {
    // TODO: Implement habit ticking
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Great job! ${habit.name} ticked!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showAddHabitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Habit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Habit Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Cadence',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'daily', child: Text('Daily')),
                DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
              ],
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement add habit
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

// Temporary mock class until we implement the actual habit model and providers
class _MockHabit {
  final String id;
  final String name;
  final String cadence;
  final int streak;
  final DateTime? lastTickAt;

  _MockHabit({
    required this.id,
    required this.name,
    required this.cadence,
    required this.streak,
    this.lastTickAt,
  });
}
