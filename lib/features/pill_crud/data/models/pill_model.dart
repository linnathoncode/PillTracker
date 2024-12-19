import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';

class PillModel {
  final String name;
  final String id;

  PillModel({
    required this.name,
    required this.id,
  });

  factory PillModel.fromJson(Map<String, dynamic> json) {
    return PillModel(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }

  factory PillModel.fromEntity(PillEntity entity) {
    return PillModel(
      name: entity.name,
      id: entity.id,
    );
  }

  PillEntity toEntity() {
    return PillEntity(
      name: name,
      id: id,
    );
  }
}
