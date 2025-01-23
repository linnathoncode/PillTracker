import 'package:flutter/material.dart';
import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';
import 'package:pill_tracker/features/pill_crud/presentation/pages/pill_info_page/widgets/detail_row_widget.dart';
import 'package:pill_tracker/features/pill_crud/presentation/pages/pill_info_page/widgets/dosage_section.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/provider.dart';
import 'package:provider/provider.dart';

class PillInfoPage extends StatefulWidget {
  const PillInfoPage({super.key});

  @override
  State<PillInfoPage> createState() => _PillInfoPageState();
}

class _PillInfoPageState extends State<PillInfoPage> {
  late final int id;
  PillEntity? pill; // Nullable since it's loaded asynchronously
  bool isLoading = true;

  /// Called when the dependencies of the widget change.
  ///
  /// This method is invoked immediately after the widget is inserted into the widget tree
  /// and whenever the dependencies change. It retrieves the `id` from the route arguments
  /// and calls the `_loadPill` method to load the pill information.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    id = ModalRoute.of(context)!.settings.arguments as int;
    _loadPill();
  }

  Future<void> _loadPill() async {
    try {
      await Provider.of<PillProvider>(context, listen: false).getPillById(id);
      setState(() {
        pill = Provider.of<PillProvider>(context, listen: false).pill!;
        isLoading = false;
      });
    } catch (e) {
      // Handle errors (optional)
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: pill?.name != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pill!.name,
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${pill!.totalPills} left",
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              )
            : const Text(
                'Loading...'), // Show loading text until pill is loaded
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : pill == null
              ? const Center(child: Text('No Pill Information Available'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildDetailRow(
                              icon: Icons.medication,
                              title: 'Medication Name',
                              value: pill!.name.isNotEmpty
                                  ? pill!.name
                                  : 'No medication name available',
                              context: context,
                            ),
                            const SizedBox(height: 16),
                            buildDetailRow(
                              icon: Icons.calendar_today,
                              title: 'Start Date',
                              value: pill?.startDate != null
                                  ? PillProvider()
                                      .formatDate(pill!.startDate)
                                      .toString()
                                  : 'No start date available',
                              context: context,
                            ),
                            const SizedBox(height: 16),
                            buildDetailRow(
                              icon: Icons.calendar_month,
                              title: 'End Date',
                              value: pill!.endDate != null
                                  ? PillProvider()
                                      .formatDate(pill!.endDate!)
                                      .toString()
                                  : 'No end date available',
                              context: context,
                            ),
                            const SizedBox(height: 16),
                            buildDosageSection(pill!, context),
                            const SizedBox(height: 16),
                            buildDetailRow(
                              icon: Icons.notes,
                              title: 'Notes',
                              value: (pill?.notes == null || pill?.notes == "")
                                  ? "No notes available"
                                  : pill!.notes!,
                              context: context,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
