class Pill {
  String name;
  int numberOfPills;
  int pillsPerDay;
  String type;
  String? note;
  List<String> period;
  DateTime startingDay;
  DateTime endingDay;

  Pill(
      {required this.name,
      required this.numberOfPills,
      required this.pillsPerDay,
      required this.startingDay,
      required this.endingDay,
      required this.type,
      required this.period,
      this.note});
}
