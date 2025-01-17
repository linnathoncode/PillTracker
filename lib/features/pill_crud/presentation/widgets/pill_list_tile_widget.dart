import 'package:flutter/material.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/provider.dart';
import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';

Widget buildPillListTile(BuildContext context, int index,
    List<PillEntity> pills, bool isSelected, PillProvider pillProvider) {
  return ListTile(
    trailing: pillProvider.selectedIndices.contains(index)
        ? IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Pill'),
                    content: const Text(
                        'Are you sure you want to delete this pill?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Delete'),
                        onPressed: () {
                          pillProvider.removePill(pills[index].id!);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              pillProvider.clearSelections();
            },
          )
        : null,
    subtitle: Text("ID: ${pills[index].id}"),
    tileColor: isSelected ? Colors.blue[100] : null,
    leading: const Icon(Icons.medication),
    onLongPress: () {
      pillProvider.toggleSelection(index);
    },
    onTap: () {
      isSelected ? pillProvider.toggleSelection(index) : null;
    },
    title: Text(pills[index].name),
  );
}
