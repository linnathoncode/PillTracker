import 'package:flutter/material.dart';
import 'package:pill_tracker/domain/entities/pill_entity.dart';
import 'package:pill_tracker/presentation/provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => PillProvider(),
        child: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Add Pill')),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final pillProvider = context.read<PillProvider>();
                      final pill = PillEntity(name: 'Fent', id: "124");
                      await pillProvider.addPill(pill);

                      pillProvider.failure != null
                          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Failed to add pill: ${pillProvider.failure?.errorMessage}')))
                          : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Pill added successfully')));
                    },
                    child: const Text("Add Pill"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final pillProvider = context.read<PillProvider>();
                      const pillId = '124';
                      await pillProvider.getPillById(pillId);

                      pillProvider.failure != null
                          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Failed to get pill: ${pillProvider.failure?.errorMessage}')))
                          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Pill fetched: ${pillProvider.pill?.name}')));
                    },
                    child: const Text("Get Pill by ID"),
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
