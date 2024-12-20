import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';

class PillModel {
  final String name;
  final String id;
  final int dosagePerDose; // Number of pills per dose
  final int dosesPerDay; // Number of doses per day
  final List<String> times; // Times of day to take the pill
  final DateTime startDate; // When the user started taking the pill
  final DateTime? endDate; // Optional: When the user stops taking the pill
  final String? notes; // Optional: Extra instructions
  final String? color; // Optional: Color coding for the pill
  final int? totalPills; // Optional: Total number of pills in stock
  final int? lowStockThreshold; // Optional: Stock threshold for warnings

  PillModel({
    required this.name,
    required this.id,
    required this.dosagePerDose,
    required this.dosesPerDay,
    required this.times,
    required this.startDate,
    this.endDate,
    this.notes,
    this.color,
    this.totalPills,
    this.lowStockThreshold,
  });

  factory PillModel.fromJson(Map<String, dynamic> json) {
    return PillModel(
      name: json['name'],
      id: json['id'],
      dosagePerDose: json['dosagePerDose'],
      dosesPerDay: json['dosesPerDay'],
      times: List<String>.from(json['times']),
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      notes: json['notes'],
      color: json['color'],
      totalPills: json['totalPills'],
      lowStockThreshold: json['lowStockThreshold'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'dosagePerDose': dosagePerDose,
      'dosesPerDay': dosesPerDay,
      'times': times,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'notes': notes,
      'color': color,
      'totalPills': totalPills,
      'lowStockThreshold': lowStockThreshold,
    };
  }

  factory PillModel.fromEntity(PillEntity entity) {
    return PillModel(
      name: entity.name,
      id: entity.id,
      dosagePerDose: entity.dosagePerDose,
      dosesPerDay: entity.dosesPerDay,
      times: entity.times,
      startDate: entity.startDate,
      endDate: entity.endDate,
      notes: entity.notes,
      color: entity.color,
      totalPills: entity.totalPills,
      lowStockThreshold: entity.lowStockThreshold,
    );
  }

  PillEntity toEntity() {
    return PillEntity(
      name: name,
      id: id,
      dosagePerDose: dosagePerDose,
      dosesPerDay: dosesPerDay,
      times: times,
      startDate: startDate,
      endDate: endDate,
      notes: notes,
      color: color,
      totalPills: totalPills,
      lowStockThreshold: lowStockThreshold,
    );
  }
}
