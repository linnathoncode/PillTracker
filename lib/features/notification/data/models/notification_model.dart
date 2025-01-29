import 'package:pill_tracker/features/notification/domain/entities/notification_entity.dart';

class NotificationModel {
  final int id;
  final String? title;
  final String? body;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
  });

  // Convert NotificationModel to NotificationEntity
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
    );
  }

// Convert NotificationEntity to NotificationModel
  static NotificationModel fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
    );
  }
}
