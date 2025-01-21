class PillEntity {
  int? id;
  String name;
  Map<String, int> dosagePerDose; // Dosage map (time -> dosage)
  DateTime startDate; // When the user started taking the pill
  DateTime? endDate;
  String? notes; // Optional: Extra instructions
  String? color; // Optional: Color coding for the pill
  int totalPills; // Total number of pills in stock

  PillEntity({
    required this.name,
    required this.dosagePerDose,
    required this.startDate,
    required this.totalPills,
    this.endDate,
    this.id,
    this.notes,
    this.color,
  });
}
