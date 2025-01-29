import 'package:either_dart/either.dart';
import 'package:pill_tracker/core/errors/failure.dart';
import 'package:pill_tracker/features/notification/data/datasources/local_notification.dart';
import 'package:pill_tracker/features/notification/data/models/notification_model.dart';
import 'package:pill_tracker/features/notification/domain/entities/notification_entity.dart';
import 'package:pill_tracker/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  @override
  Future<Either<Failure, void>> showNotification(
      NotificationEntity notificationEntity) async {
    try {
      final NotificationModel notificationModel =
          NotificationModel.fromEntity(notificationEntity);
      await LocalNotification().showNotification(notif: notificationModel);
      return const Right(null);
    } catch (e) {
      return Left(NotificationFailure(
          e is NotificationFailure ? e.errorMessage : e.toString()));
    }
  }
}
