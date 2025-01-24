import 'package:flutter/material.dart';
import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/provider.dart';
import 'package:provider/provider.dart';

class CompactPillTile extends StatefulWidget {
  final PillEntity pill;
  final bool isSelected;
  final Widget? trailing;
  final VoidCallback onTapFunction;
  final VoidCallback onLongPressFunction;
  final int index;

  const CompactPillTile({
    super.key,
    this.trailing,
    this.isSelected = false,
    required this.pill,
    required this.onTapFunction,
    required this.onLongPressFunction,
    required this.index,
  });

  @override
  State<CompactPillTile> createState() => _CompactPillTileState();
}

class _CompactPillTileState extends State<CompactPillTile> {
  @override
  Widget build(BuildContext context) {
    final pillProvider = Provider.of<PillProvider>(context, listen: false);
    final isSelected = pillProvider.selectedIndices.contains(widget.index);

    return Card(
      color: isSelected ? Colors.orange : Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isSelected ? Colors.white : Colors.grey.withOpacity(0.3),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        title: Text(
          widget.pill.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Start: ${pillProvider.formatDate(widget.pill.startDate)}',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontSize: 12,
              ),
            ),
            Text(
              'Remaining pills: ${widget.pill.totalPills}',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        leading: Icon(
          Icons.medication,
          color: isSelected ? Colors.white : Theme.of(context).primaryColor,
        ),
        trailing: isSelected
            ? IconButton(
                icon: Icon(Icons.delete,
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).primaryColor),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Delete Pill'),
                        content: const Text(
                            'Are you sure you want to delete this pill?'),
                        actions: [
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Delete'),
                            onPressed: () {
                              pillProvider.removePill(widget.pill.id!);
                              pillProvider.clearSelections();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            : null,
        onLongPress: widget.onLongPressFunction,
        onTap: widget.onTapFunction,
      ),
    );
  }
}
