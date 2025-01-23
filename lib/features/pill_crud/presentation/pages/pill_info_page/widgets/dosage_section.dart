import 'package:flutter/material.dart';
import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';

Widget buildDosageSection(PillEntity pill, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
            Icons.medication_liquid,
            color: Theme.of(context).primaryColor,
            size: 30,
          ),
          const SizedBox(width: 16),
          Text(
            'Dosage',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.only(left: 46),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (pill.dosagePerDose['Morning']?.toDouble() != 0.0)
              buildDosageRow('Morning',
                  pill.dosagePerDose['Morning']!.toDouble(), context),
            if (pill.dosagePerDose['Noon']?.toDouble() != 0.0)
              buildDosageRow(
                  'Noon', pill.dosagePerDose['Noon']!.toDouble(), context),
            if (pill.dosagePerDose['Afternoon']?.toDouble() != 0.0)
              buildDosageRow('Afternoon',
                  pill.dosagePerDose['Afternoon']!.toDouble(), context),
            if (pill.dosagePerDose['Evening']?.toDouble() != 0.0)
              buildDosageRow('Evening',
                  pill.dosagePerDose['Evening']!.toDouble(), context),
          ],
        ),
      ),
    ],
  );
}

Widget buildDosageRow(String timePeriod, double dosage, BuildContext context) {
  return Row(
    children: [
      Text(
        timePeriod,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        ),
      ),
      const SizedBox(width: 16),
      Text(
        '$dosage mg',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ],
  );
}
