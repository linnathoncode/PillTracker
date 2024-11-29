import 'package:flutter/material.dart';

class BottomSheet extends StatefulWidget {
  final dynamic addPills; // dont care about return type?
  const BottomSheet({super.key, required this.addPills});

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  late final TextEditingController nameController;
  late final TextEditingController numberOfPillsController;
  late final TextEditingController pillsPerDayController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    numberOfPillsController = TextEditingController();
    pillsPerDayController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    numberOfPillsController.dispose();
    pillsPerDayController.dispose();
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
            Row(
              children: [
                const Text("Name of the pill: "),
                Expanded(
                  child: TextField(
                    controller: nameController,
                    autofocus: true,
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
                onPressed: () {
                  // required String name,
                  // required int numberOfPills,
                  // required int pillsPerDay,
                  widget.addPills(
                      name: nameController.text.toString(),
                      numberOfPills: int.parse(numberOfPillsController.text),
                      pillsPerDay: int.parse(pillsPerDayController.text));
                  Navigator.of(context).pop();
                },
                child: const Text("Save Pill")),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
