import 'package:flutter/material.dart';

class BottomSheet extends StatefulWidget {
  final dynamic addPills; // don't care about return type?
  const BottomSheet({super.key, required this.addPills});

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  late final TextEditingController nameController;
  late final TextEditingController numberOfPillsController;
  late final TextEditingController pillsPerDayController;

  final List<String> dropDownItems = ["Pill", "Syrup", "Other"];
  String? _dropdownValue;
  final GlobalKey _dropdownKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    numberOfPillsController = TextEditingController();
    pillsPerDayController = TextEditingController();
    _dropdownValue = dropDownItems.first; // Default selection
  }

  @override
  void dispose() {
    nameController.dispose();
    numberOfPillsController.dispose();
    pillsPerDayController.dispose();
    super.dispose();
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
    return Container(
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
            Row(
              children: [
                const Text("Name of the pill: "),
                Expanded(
                  child: TextField(
                    controller: nameController,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Number of pills: "),
                Expanded(
                  child: TextField(
                    controller: numberOfPillsController,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Pills per day: "),
                Expanded(
                  child: TextField(
                    controller: pillsPerDayController,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: () {
                widget.addPills(
                  name: nameController.text.toString(),
                  numberOfPills: int.parse(numberOfPillsController.text),
                  pillsPerDay: int.parse(pillsPerDayController.text),
                );
                Navigator.of(context).pop();
              },
              child: const Text("Save Pill"),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
