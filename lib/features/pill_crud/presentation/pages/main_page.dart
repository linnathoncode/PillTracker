import 'package:flutter/material.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/bottom_sheet_view_model.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/provider.dart';
import 'package:pill_tracker/features/pill_crud/presentation/widgets/bottom_sheet_widget.dart';
import 'package:pill_tracker/features/pill_crud/presentation/widgets/pill_list_tile_widget.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Pill Tracker",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ChangeNotifierProvider(
                  create: (context) => PillProvider(),
                  child: Builder(
                    builder: (context) {
                      final pillProvider = Provider.of<PillProvider>(context);
                      pillProvider.getAllPills();
                      final pills = pillProvider.pills;
                      if (pills == null || pills.isEmpty) {
                        return Center(
                          child: pillProvider.failure == null
                              ? const Text('No pills available')
                              : const Text('Failed to get pills'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: pills.length,
                          itemBuilder: (context, index) {
                            final isSelected =
                                pillProvider.selectedIndices.contains(index);
                            return buildPillListTile(
                              context,
                              index,
                              pills,
                              isSelected,
                              pillProvider,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor:
            Theme.of(context).floatingActionButtonTheme.foregroundColor,
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        shape: Theme.of(context).floatingActionButtonTheme.shape,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
            isScrollControlled: true,
            builder: (_) {
              return ChangeNotifierProvider(
                create: (_) => BottomSheetViewModel(),
                child: const BottomSheetWidget(),
              );
            },
          );
        },
        child: Icon(Icons.add,
            size: Theme.of(context).floatingActionButtonTheme.iconSize),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
