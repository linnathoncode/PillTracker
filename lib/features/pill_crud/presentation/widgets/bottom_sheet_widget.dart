import 'package:flutter/material.dart';
import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/provider.dart';
import 'package:pill_tracker/features/pill_crud/presentation/widgets/custom_checkbox_list_tile_widget.dart';
import 'package:provider/provider.dart';
import './custom_text_form_field_widget.dart' as custom;

class BottomSheet extends StatefulWidget {
  const BottomSheet({super.key});

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  //   String id;
  // String name;
  // int dosagePerDose; // Number of pills per dose
  // int dosesPerDay; // Number of doses per day
  // List<String>
  //     times; // Times of day to take the pill (e.g., "8:00 AM", "2:00 PM")
  // DateTime startDate; // When the user started taking the pill
  // DateTime? endDate; // Optional: When the user stops taking the pill
  // String? notes; // Optional: Extra instructions
  // String? color; // Optional: Color coding for the pill
  // int? totalPills; // Optional: Total number of pills in stock
  // int? lowStockThreshold; // Optional: Stock threshold for warnings
  late final TextEditingController nameController;
  late final TextEditingController dosagePerDoseController;
  late final TextEditingController dosagePerDayController;
  late final TextEditingController startDateController;
  late final _formKey = GlobalKey<FormState>();
  late bool isMorning;
  late bool isNoon;
  late bool isAfternoon;
  late bool isEvening;

  final List<String> dropDownItems = ["Pill", "Syrup", "Other"];
  String? _dropdownValue;
  final GlobalKey _dropdownKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dosagePerDoseController = TextEditingController();
    startDateController = TextEditingController();
    isMorning = false;
    isNoon = false;
    isAfternoon = false;
    isEvening = false;
    _dropdownValue = dropDownItems.first; // Default selection
  }

  @override
  void dispose() {
    nameController.dispose();
    dosagePerDoseController.dispose();
    startDateController.dispose();

    super.dispose();
  }

  void _handlePillAdd() async {
    if (_formKey.currentState?.validate() ?? false) {
      final pillProvider = Provider.of<PillProvider>(context, listen: false);

      // Fetch pills and wait for the result if asynchronous
      await pillProvider.getAllPills();

      if (pillProvider.failure != null) {
        // Log error and exit
        print("Error fetching pills: ${pillProvider.failure!.errorMessage}");
        return;
      }

      // Add times based on the selected checkboxes
      List<String> times = [];
      if (isMorning) times.add("Morning");
      if (isNoon) times.add("Noon");
      if (isAfternoon) times.add("Afternoon");
      if (isEvening) times.add("Evening");
      // Calculate the next pill ID
      String lastPillId = '0';
      if (pillProvider.pills != null && pillProvider.pills!.isNotEmpty) {
        //sort the ids get the last one and add one
        lastPillId = (pillProvider.pills!
                    .map((pill) => int.parse(pill.id))
                    .reduce((a, b) => a > b ? a : b) +
                1)
            .toString();
        print(lastPillId);
      }

      // Create a new pill and add it
      final pill = PillEntity(
          name: nameController.text,
          id: lastPillId,
          dosagePerDose: int.parse(dosagePerDoseController.text),
          dosesPerDay: times.length,
          times: times,
          startDate: DateTime.now());
      await pillProvider.addPill(pill);

      if (pillProvider.failure != null) {
        print("Error adding pill: ${pillProvider.failure!.errorMessage}");
      } else {
        print(pill);
        Navigator.pop(context);
      }
    }
  }

  // GPT CODE !!!
  Future<void> _showDropdownMenu(BuildContext context) async {
    // Dismiss the keyboard first
    FocusScope.of(context).unfocus();
    await Future.delayed(
        const Duration(milliseconds: 300)); // Wait for bottom sheet adjustment

    // cok da guvenli durmuyor
    if (!context.mounted || !mounted) return;

    // Get the dropdown button's position
    final renderBox =
        _dropdownKey.currentContext?.findRenderObject() as RenderBox?;
    final overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox?;

    if (renderBox != null && overlay != null) {
      final position = RelativeRect.fromRect(
        Rect.fromPoints(
          renderBox.localToGlobal(Offset.zero, ancestor: overlay),
          renderBox.localToGlobal(renderBox.size.bottomLeft(Offset.zero),
              ancestor: overlay),
        ),
        Offset.zero & overlay.size,
      );

      // Show the dropdown menu
      final selectedValue = await showMenu<String>(
        context: context,
        position: position,
        color: Theme.of(context).primaryColor,
        items: dropDownItems.map((item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
              ),
            ),
          );
        }).toList(),
      );

      if (selectedValue != null) {
        setState(() {
          _dropdownValue = selectedValue;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // DROP DOWN BUTTON
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Type of medicine: "),
                  const SizedBox(width: 5),
                  Expanded(
                    child: GestureDetector(
                      key: _dropdownKey,
                      onTap: () => _showDropdownMenu(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _dropdownValue ?? "Select",
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.fontSize,
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // TEXT FIELDS
              const SizedBox(
                height: 10,
              ),
              custom.customTextFormField(
                nameController,
                false,
                TextInputType.text,
                "Please enter the name of the pill",
                25,
                "e.g. Aspririn.",
                false,
              ),
              const SizedBox(
                height: 10,
              ),
              custom.customTextFormField(
                dosagePerDoseController,
                false,
                TextInputType.number,
                "Number of dosage per dpose",
                25,
                "e.g. 2",
                true,
              ),
              const SizedBox(
                height: 10,
              ),

              SizedBox(
                child: Wrap(
                  spacing: 4.0, // Optional: Add spacing between items
                  runSpacing: 0.0, // Optional: Add spacing between rows
                  children: [
                    CustomCheckboxListTile(
                      title: "Morning",
                      value: isMorning,
                      onChanged: (value) {
                        setState(() {
                          isMorning = !isMorning;
                        });
                      },
                    ),
                    CustomCheckboxListTile(
                      title: "Noon",
                      value: isNoon,
                      onChanged: (value) {
                        setState(() {
                          isNoon = !isNoon;
                        });
                      },
                    ),
                    CustomCheckboxListTile(
                      title: "Afternoon",
                      value: isAfternoon,
                      onChanged: (value) {
                        setState(() {
                          isAfternoon = !isAfternoon;
                        });
                      },
                    ),
                    CustomCheckboxListTile(
                      title: "Evening",
                      value: isEvening,
                      onChanged: (value) {
                        setState(() {
                          isEvening = !isEvening;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () {
                  _handlePillAdd();
                },
                child: const Text("Save Pill"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
