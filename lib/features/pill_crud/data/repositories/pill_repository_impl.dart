import 'package:either_dart/either.dart';
import 'package:pill_tracker/core/errors/failure.dart';
import 'package:pill_tracker/features/pill_crud/data/datasources/pill_local_database.dart';
import 'package:pill_tracker/features/pill_crud/data/models/pill_model.dart';
import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';
import 'package:pill_tracker/features/pill_crud/domain/repositories/pill_repository.dart';

class PillRepositoryImpl implements PillRepository {
  final PillLocalDatabase _pillLocalDatabase;

  PillRepositoryImpl(this._pillLocalDatabase);

  @override
  Future<Either<Failure, PillEntity>> addPill(PillEntity pill) async {
    try {
      final pillModel = PillModel.fromEntity(pill);
      await _pillLocalDatabase.addPill(pillModel);
      return Right(pill);
    } catch (e) {
      return Left(
        DatabaseFailure(
          e is DatabaseFailure ? e.errorMessage : e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> removePill(int id) async {
    try {
      await _pillLocalDatabase.removePill(id);
      return const Right(null);
    } catch (e) {
      return Left(
        DatabaseFailure(
          e is DatabaseFailure ? e.errorMessage : e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<PillEntity>>> getAllPills() async {
    try {
      final pillsModels = await _pillLocalDatabase.getAllPills();
      final pills = pillsModels.map((model) => model.toEntity()).toList();
      return Right(pills);
    } catch (e) {
      return Left(
        DatabaseFailure(
          e is DatabaseFailure ? e.errorMessage : e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, PillEntity>> getPillById(String id) async {
    try {
      // Directly get the PillModel (no need to cast from Map)
      final pill = await _pillLocalDatabase.getPillById(id);

      if (pill != null) {
        // Convert PillModel to PillEntity
        return Right(pill.toEntity());
      }
      return Left(DatabaseFailure('Pill not found'));
    } catch (e) {
      return Left(
        DatabaseFailure(
          e is DatabaseFailure ? e.errorMessage : e.toString(),
        ),
      );
    }
  }
}
