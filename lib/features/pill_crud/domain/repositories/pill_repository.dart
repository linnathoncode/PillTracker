import 'package:pill_tracker/core/errors/failure.dart';
import 'package:either_dart/either.dart';
import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';

abstract class PillRepository {
  Future<Either<Failure, PillEntity>> addPill(PillEntity pill);
  Future<Either<Failure, void>> removePill(int id);
  Future<Either<Failure, PillEntity>> getPillById(int id);
  Future<Either<Failure, List<PillEntity>>> getAllPills();
}
