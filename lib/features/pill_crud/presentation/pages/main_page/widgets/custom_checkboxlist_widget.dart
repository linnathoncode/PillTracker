import 'package:flutter/material.dart';
import 'package:pill_tracker/features/pill_crud/presentation/pages/main_page/view_models/bottom_sheet_view_model.dart';
import 'package:provider/provider.dart';

class CustomCheckboxList extends StatelessWidget {
  const CustomCheckboxList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomSheetViewModel>(context);

    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: provider.timeOptions.entries.map((entry) {
        final key = entry.key;
        final isChecked = entry.value;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: CheckboxListTile(
                title: Text(key),
                value: isChecked,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  provider.toggleCheckbox(key, value ?? false);
                },
              ),
            ),
            if (isChecked)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => provider.decrementCounter(key),
                  ),
                  Text(provider.counters[key].toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => provider.incrementCounter(key),
                  ),
                ],
              ),
          ],
        );
      }).toList(),
    );
  }
}
