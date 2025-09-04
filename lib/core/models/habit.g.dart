// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HabitImpl _$$HabitImplFromJson(Map<String, dynamic> json) => _$HabitImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      cadence: $enumDecodeNullable(_$HabitCadenceEnumMap, json['cadence']) ??
          HabitCadence.daily,
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      lastTickAt: json['lastTickAt'] == null
          ? null
          : DateTime.parse(json['lastTickAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isSynced: json['isSynced'] as bool? ?? false,
    );

Map<String, dynamic> _$$HabitImplToJson(_$HabitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cadence': _$HabitCadenceEnumMap[instance.cadence]!,
      'streak': instance.streak,
      'lastTickAt': instance.lastTickAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isSynced': instance.isSynced,
    };

const _$HabitCadenceEnumMap = {
  HabitCadence.daily: 'daily',
  HabitCadence.weekly: 'weekly',
  HabitCadence.monthly: 'monthly',
};
