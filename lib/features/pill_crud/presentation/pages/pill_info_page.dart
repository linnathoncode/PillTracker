import 'package:flutter/material.dart';
import 'package:pill_tracker/features/pill_crud/domain/entities/pill_entity.dart';
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
        title: Text(pill?.name != null
            ? "${pill?.name} ${pill?.totalPills} left"
            : 'Loading...'), // Show loading text until pill is loaded
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Loading indicator
          : Center(
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(pill!.startDate.toString()),
                      Text(pill!.endDate.toString()),
                      Text(pill!.dosagePerDose.toString()),
                      Text(pill!.notes.toString()),
                    ],
                  )), // Replace with actual UI
            ),
    );
  }
}
