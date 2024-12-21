import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onValueChanged;

  const CustomDropdownMenu({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Type of medicine: "),
        const SizedBox(width: 5),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onValueChanged,
          ),
        ),
      ],
    );
  }
}
