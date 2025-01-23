import 'package:flutter/material.dart';
import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/provider.dart';

class CompactPillTile extends StatelessWidget {
  final PillEntity pill;
  final bool isSelected;
  final Widget? trailing;
  final VoidCallback onTapFunction;
  final VoidCallback onLongPressFunction;

  const CompactPillTile({
    super.key,
    this.trailing,
    this.isSelected = false,
    required this.pill,
    required this.onTapFunction,
    required this.onLongPressFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.grey.withOpacity(0.3),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        title: Text(
          pill.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Start: ${PillProvider().formatDate(pill.startDate)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            Text(
              'Remaining pills: ${pill.totalPills}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        leading: Icon(
          Icons.medication,
          color: Theme.of(context).primaryColor,
        ),
        trailing: trailing,
        // onlong press does not work
        onLongPress: onLongPressFunction,
        onTap: onTapFunction,
      ),
    );
  }
}
