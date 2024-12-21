import 'package:flutter/material.dart';

class CustomCheckboxList extends StatelessWidget {
  final Map<String, bool> options;
  final ValueChanged<String> onChanged;

  const CustomCheckboxList({
    super.key,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: options.entries.map((entry) {
        return CheckboxListTile(
          title: Text(entry.key),
          value: entry.value,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (value) => onChanged(entry.key),
        );
      }).toList(),
    );
  }
}
