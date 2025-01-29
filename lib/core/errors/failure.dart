class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(super.errorMessage);
}

class NotificationFailure extends Failure {
  NotificationFailure(super.errorMessage);
}
