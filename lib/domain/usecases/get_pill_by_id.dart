import 'package:either_dart/either.dart';
import 'package:pill_tracker/core/errors/failure.dart';
import 'package:pill_tracker/domain/entities/pill_entity.dart';
import 'package:pill_tracker/domain/repositories/pill_repository.dart';

class GetPillById {
  final PillRepository repository;

  GetPillById(this.repository);

  Future<Either<Failure, PillEntity>> call(String id) async {
    return await repository.getPillById(id);
  }
}
