import 'package:flutter/material.dart';
import 'package:pill_tracker/core/errors/failure.dart';
import 'package:pill_tracker/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:pill_tracker/features/notification/domain/entities/notification_entity.dart';
import 'package:pill_tracker/features/notification/domain/usecases/show_notification.dart';

class NotificationProvider extends ChangeNotifier {
  Failure? failure;

  Future<void> showNotification(int id, String? title, String? body) async {
    final NotificationEntity entity = NotificationEntity(
      id: id,
      title: title,
      body: body,
    );

    final repository = NotificationRepositoryImpl();
    final showNotificationUseCase = ShowNotification(repository: repository);
    final result = await showNotificationUseCase(entity);
    result.fold(
      (newFailure) {
        failure = newFailure;
        notifyListeners();
      },
      (fetchedPill) {
        failure = null;
        notifyListeners();
      },
    );
  }
}
