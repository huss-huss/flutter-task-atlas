import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment.freezed.dart';
part 'attachment.g.dart';

enum OwnerType {
  task,
  note,
  habit,
}

enum AttachmentType {
  image,
  document,
  audio,
}

@freezed
class Attachment with _$Attachment {
  const factory Attachment({
    required String id,
    required OwnerType ownerType,
    required String ownerId,
    required String pathOrUrl,
    required AttachmentType type,
    required DateTime createdAt,
    @Default(false) bool isSynced,
  }) = _Attachment;

  factory Attachment.fromJson(Map<String, dynamic> json) => _$AttachmentFromJson(json);
}
