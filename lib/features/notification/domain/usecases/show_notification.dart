import 'package:either_dart/either.dart';
import 'package:pill_tracker/core/errors/failure.dart';
import 'package:pill_tracker/features/notification/domain/entities/notification_entity.dart';
import 'package:pill_tracker/features/notification/domain/repositories/notification_repository.dart';

class ShowNotification {
  final NotificationRepository repository;

  ShowNotification({required this.repository});
  Future<Either<Failure, void>> call(NotificationEntity notification) async {
    return await repository.showNotification(notification);
  }
}
