import 'package:either_dart/either.dart';
import 'package:pill_tracker/core/errors/failure.dart';
import 'package:pill_tracker/features/pill_crud/domain/repositories/pill_repository.dart';

class RemovePill {
  final PillRepository repository;

  RemovePill(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.removePill(id);
  }
}
