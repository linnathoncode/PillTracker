class PillEntity {
  String id;
  String name;
  int dosagePerDose; // Number of pills per dose
  int dosesPerDay; // Number of doses per day
  List<String>
      times; // Times of day to take the pill (e.g., "8:00 AM", "2:00 PM")
  DateTime startDate; // When the user started taking the pill
  DateTime? endDate; // Optional: When the user stops taking the pill
  String? notes; // Optional: Extra instructions
  String? color; // Optional: Color coding for the pill
  int? totalPills; // Optional: Total number of pills in stock
  int? lowStockThreshold; // Optional: Stock threshold for warnings

  PillEntity({
    required this.id,
    required this.name,
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
}
