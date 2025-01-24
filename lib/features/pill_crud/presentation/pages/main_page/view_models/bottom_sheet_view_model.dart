import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/provider.dart';

class BottomSheetViewModel extends ChangeNotifier {
  // Form state and controllers
  final nameKey = GlobalKey<FormState>();
  final totalPillsKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final totalPillsController = TextEditingController();

  // Dropdown state
  List<String> dropDownItems = ["Pill", "Syrup", "Other"];
  String? selectedDropdownValue;

  // Checkbox state
  Map<String, bool> timeOptions = {
    "Morning": false,
    "Noon": false,
    "Afternoon": false,
    "Evening": false,
  };

  Map<String, int> counters = {
    "Morning": 0,
    "Noon": 0,
    "Afternoon": 0,
    "Evening": 0,
  };

  //checkboxlist

  // Update checkbox state
  void toggleCheckbox(String key, bool isChecked) {
    if (timeOptions.containsKey(key)) {
      timeOptions[key] = isChecked;
      counters[key] = 0;
      notifyListeners();
    }
  }

  // Increment counter
  void incrementCounter(String key) {
    if (counters.containsKey(key)) {
      counters[key] = counters[key]! + 1;
      notifyListeners();
    }
  }

  // Decrement counter
  void decrementCounter(String key) {
    if (counters.containsKey(key) && counters[key]! > 0) {
      counters[key] = counters[key]! - 1;
      notifyListeners();
    }
  }

  BottomSheetViewModel() {
    selectedDropdownValue = dropDownItems.first;
  }

  // Validator for Name
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter a name.";
    }
    if (value.length > 25) {
      return "Name cannot exceed 25 characters.";
    }
    return null;
  }

  // Validator for Dosage
  String? validateTotalPills(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter a dosage.";
    }
    if (int.tryParse(value) == null) {
      return "Dosage must be a valid number.";
    }
    return null;
  }

  // Dropdown logic
  void updateDropdownValue(String? value) {
    selectedDropdownValue = value;
    notifyListeners();
  }

  void updateTimeOption(Map<String, dynamic> updatedOption) {
    final key = updatedOption.keys.first;
    if (timeOptions.containsKey(key)) {
      timeOptions[key] = updatedOption[key]['isChecked'] ?? false;
      notifyListeners();
    } else {
      throw ArgumentError('Key "$key" does not exist in timeOptions.');
    }
  }

  // Save Pill logic
  Future<void> savePill(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    final pillProvider = Provider.of<PillProvider>(context, listen: false);

    // Check if pills list is null or empty
    // If pills doest get fetched pillProvider.pill will be empty
    await pillProvider.getAllPills();
    final pillCount = pillProvider.pills?.length ?? 0;
    debugPrint(pillCount.toString());

    // Get selected times
    List<String> selectedTimes = timeOptions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    // Create a new pill entity
    // fix the dosageperdose in the database by storing it as a map
    final pill = PillEntity(
      name: nameController.text,
      dosagePerDose: counters,
      startDate: DateTime.now(),
      totalPills: int.parse(totalPillsController.text),
      id: null,
      notes: null,
      color: null,
    );
    // print("PILL ENTITIY $pill");
    // print("Pill Entity Details:");
    // print("Name: ${pill.name}");
    // print("Dosage Per Dose: ${pill.dosagePerDose}");
    // print("Start Date: ${pill.startDate}");
    // print("Total Pills: ${pill.totalPills}");
    // print("ID: ${pill.id}");
    // print("Notes: ${pill.notes}");
    // print("Color: ${pill.color}");

    // Save the pill via the provider
    await pillProvider.addPill(pill);

    if (pillProvider.failure != null) {
      debugPrint("Error: ${pillProvider.failure!.errorMessage}");
    } else {
      if (context.mounted) {
        Navigator.pop(context); // Close the bottom sheet
      }
    }
  }
}
