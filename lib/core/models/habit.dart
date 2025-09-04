import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit.freezed.dart';
part 'habit.g.dart';

enum HabitCadence {
  daily,
  weekly,
  monthly,
}

@freezed
class Habit with _$Habit {
  const factory Habit({
    required String id,
    required String name,
    @Default(HabitCadence.daily) HabitCadence cadence,
    @Default(0) int streak,
    DateTime? lastTickAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isSynced,
  }) = _Habit;

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);
}
