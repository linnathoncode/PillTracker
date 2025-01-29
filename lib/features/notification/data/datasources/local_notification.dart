import 'package:either_dart/either.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pill_tracker/core/errors/failure.dart';
import 'package:pill_tracker/features/notification/data/models/notification_model.dart';

class LocalNotification {
  final notificationPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  // init
  Future<void> initNotification() async {
    if (_isInitialized) return;

    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationPlugin.initialize(initSettings);
  }

  // notification detail setup
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'channel description',
          importance: Importance.max,
          priority: Priority.max,
        ),
        iOS: DarwinNotificationDetails());
  }

  // show notificaition
  Future<Either<Failure, void>> showNotification(
      {required NotificationModel notif}) async {
    try {
      notificationPlugin.show(
        notif.id,
        notif.title,
        notif.body,
        notificationDetails(),
      );
      return const Right(null);
    } catch (e) {
      return Left(
        NotificationFailure(e.toString()),
      );
    }

    // on notification tap
  }
}
