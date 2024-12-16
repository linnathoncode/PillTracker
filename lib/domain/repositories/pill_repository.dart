import 'package:pill_tracker/core/errors/failure.dart';
import 'package:pill_tracker/domain/entities/pill_entity.dart';
import 'package:either_dart/either.dart';

abstract class PillRepository {
  Future<Either<Failure, PillEntity>> addPill(PillEntity pill);
  Future<Either<Failure, void>> removePill(String id);
  Future<Either<Failure, PillEntity>> getPillById(String id);
  Future<Either<Failure, List<PillEntity>>> getAllPills();
}
