import 'package:flutter/material.dart';
import 'package:pill_tracker/data/datasources/pill_local_database.dart';
import 'package:pill_tracker/data/pill_repository_impl.dart';
import 'package:pill_tracker/domain/entities/pill_entity.dart';
import 'package:pill_tracker/domain/usecases/add_pill.dart';
import 'package:pill_tracker/domain/usecases/get_pill_by_id.dart';
import 'package:pill_tracker/core/errors/failure.dart';

class PillProvider extends ChangeNotifier {
  PillEntity? pill;
  Failure? failure;

  PillProvider({
    this.pill,
    this.failure,
  });

  /// Method to add a pill
  Future<void> addPill(PillEntity pillEntity) async {
    final pillRepository = PillRepositoryImpl(
        PillLocalDatabase.instance); // Initialize the repository
    final addPillUseCase = AddPill(pillRepository);

    final result = await addPillUseCase(pillEntity);

    result.fold(
      (newFailure) {
        pill = null;
        failure = newFailure;
        notifyListeners();
      },
      (success) {
        pill = pillEntity;
        failure = null;
        notifyListeners();
      },
    );
  }

  /// Method to fetch a pill by its ID
  Future<void> getPillById(String id) async {
    final pillRepository = PillRepositoryImpl(
        PillLocalDatabase.instance); // Initialize the repository
    final getPillByIdUseCase = GetPillById(pillRepository);

    final result = await getPillByIdUseCase(id);

    result.fold(
      (newFailure) {
        pill = null;
        failure = newFailure;
        notifyListeners();
      },
      (fetchedPill) {
        pill = fetchedPill;
        failure = null;
        notifyListeners();
      },
    );
  }
}
