// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttachmentImpl _$$AttachmentImplFromJson(Map<String, dynamic> json) =>
    _$AttachmentImpl(
      id: json['id'] as String,
      ownerType: $enumDecode(_$OwnerTypeEnumMap, json['ownerType']),
      ownerId: json['ownerId'] as String,
      pathOrUrl: json['pathOrUrl'] as String,
      type: $enumDecode(_$AttachmentTypeEnumMap, json['type']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isSynced: json['isSynced'] as bool? ?? false,
    );

Map<String, dynamic> _$$AttachmentImplToJson(_$AttachmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerType': _$OwnerTypeEnumMap[instance.ownerType]!,
      'ownerId': instance.ownerId,
      'pathOrUrl': instance.pathOrUrl,
      'type': _$AttachmentTypeEnumMap[instance.type]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'isSynced': instance.isSynced,
    };

const _$OwnerTypeEnumMap = {
  OwnerType.task: 'task',
  OwnerType.note: 'note',
  OwnerType.habit: 'habit',
};

const _$AttachmentTypeEnumMap = {
  AttachmentType.image: 'image',
  AttachmentType.document: 'document',
  AttachmentType.audio: 'audio',
};
