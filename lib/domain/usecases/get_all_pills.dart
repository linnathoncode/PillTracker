import 'package:either_dart/either.dart';
import 'package:pill_tracker/core/errors/failure.dart';
import 'package:pill_tracker/domain/entities/pill_entity.dart';
import 'package:pill_tracker/domain/repositories/pill_repository.dart';

class GetAllPills {
  final PillRepository repository;

  GetAllPills(this.repository);

  Future<Either<Failure, List<PillEntity>>> call() async {
    return await repository.getAllPills();
  }
}
