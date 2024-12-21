import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/provider.dart';

class BottomSheetViewModel extends ChangeNotifier {
  // Form state and controllers
  final nameKey = GlobalKey<FormState>();
  final dosageKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final dosagePerDoseController = TextEditingController();

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
  String? validateDosage(String? value) {
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

  // Checkbox logic
  void updateTimeOption(String key) {
    timeOptions[key] = !timeOptions[key]!;
    notifyListeners();
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
    final pill = PillEntity(
      id: (pillCount + 1).toString(),
      name: nameController.text,
      dosagePerDose: int.parse(dosagePerDoseController.text),
      dosesPerDay: selectedTimes.length,
      times: selectedTimes,
      startDate: DateTime.now(),
    );

    // Save the pill via the provider
    await pillProvider.addPill(pill);

    if (pillProvider.failure != null) {
      debugPrint("Error: ${pillProvider.failure!.errorMessage}");
    } else {
      Navigator.pop(context); // Close the bottom sheet
    }
  }
}
