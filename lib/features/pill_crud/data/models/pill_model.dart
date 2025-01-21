import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';

class PillModel {
  final String name;
  final Map<String, int> dosagePerDose; // Dosage map (time -> dosage)
  final DateTime startDate; // When the user started taking the pill
  final int totalPills; // Mandatory: Total number of pills in stock
  final int? id;
  final DateTime? endDate; // When the user started taking the pill
  final String? notes; // Optional: Extra instructions
  final String? color; // Optional: Color coding for the pill

  PillModel({
    required this.name,
    required this.dosagePerDose,
    required this.startDate,
    required this.totalPills,
    this.id,
    this.notes,
    this.color,
    this.endDate,
  });

  /// Factory to create a PillModel from JSON
  factory PillModel.fromJson(Map<String, dynamic> json) {
    return PillModel(
      name: json['name'],
      id: json['id'],
      dosagePerDose:
          Map<String, int>.from(_deserializeMap(json['dosagePerDose'])),
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      notes: json['notes'] ?? '',
      color: json['color'] ?? '',
      totalPills: json['totalPills'],
    );
  }

  /// Convert PillModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'dosagePerDose': _serializeMap(dosagePerDose),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'notes': notes,
      'color': color,
      'totalPills': totalPills,
    };
  }

  /// Create a PillModel from a PillEntity
  factory PillModel.fromEntity(PillEntity entity) {
    return PillModel(
      name: entity.name,
      id: entity.id,
      dosagePerDose: entity.dosagePerDose,
      startDate: entity.startDate,
      endDate: entity.endDate,
      notes: entity.notes,
      color: entity.color,
      totalPills: entity.totalPills,
    );
  }

  /// Convert PillModel to a PillEntity
  PillEntity toEntity() {
    return PillEntity(
      name: name,
      id: id,
      dosagePerDose: dosagePerDose,
      startDate: startDate,
      endDate: endDate,
      notes: notes,
      color: color,
      totalPills: totalPills,
    );
  }

  /// Helper to serialize a map (time -> dosage) into a JSON string
  static String _serializeMap(Map<String, int> map) {
    return map.isNotEmpty
        ? map.entries.map((e) => '${e.key}:${e.value}').join(',')
        : '';
  }

  /// Helper to deserialize a JSON string into a map (time -> dosage)
  static Map<String, int> _deserializeMap(String mapString) {
    if (mapString.isEmpty) return {};
    return Map.fromEntries(mapString.split(',').map((entry) {
      final splitEntry = entry.split(':');
      return MapEntry(splitEntry[0], int.parse(splitEntry[1]));
    }));
  }
}
