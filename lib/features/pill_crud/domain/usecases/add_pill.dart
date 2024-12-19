import 'package:either_dart/either.dart';
import 'package:pill_tracker/core/errors/failure.dart';
import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';
import 'package:pill_tracker/features/pill_crud/domain/repositories/pill_repository.dart';

class AddPill {
  final PillRepository repository;

  AddPill(this.repository);

  Future<Either<Failure, PillEntity>> call(PillEntity pill) async {
    return await repository.addPill(pill);
  }
}
