import 'package:flutter/material.dart';
import 'package:pill_tracker/domain/entities/pills.dart';
import 'package:pill_tracker/presentation/bottom_sheet/pages/bottom_sheet.dart'
    as custom;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Pill> pills = [
    Pill(
      name: 'Vitamin C',
      numberOfPills: 30,
      pillsPerDay: 1,
      startingDay: DateTime.now(),
      endingDay: DateTime.now().add(const Duration(days: 30)),
      type: '',
      period: [],
    ),
    Pill(
      name: 'Omega 3',
      numberOfPills: 60,
      pillsPerDay: 2,
      startingDay: DateTime.now(),
      endingDay: DateTime.now().add(const Duration(days: 30)),
      type: '',
      period: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Pill addPills({
      required String name,
      required int numberOfPills,
      required int pillsPerDay,
    }) {
      Pill pill = Pill(
        name: name,
        numberOfPills: numberOfPills,
        pillsPerDay: pillsPerDay,
        startingDay: DateTime.now(),
        endingDay: DateTime.now().add(const Duration(days: 30)),
        type: '',
        period: [],
      );
      setState(() {
        pills.add(pill);
      });
      return pill;
    }

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
                child: ListView.builder(
                  itemCount: pills.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.medication_rounded),
                      subtitle: Text(
                          "Number of Pills: ${pills[index].numberOfPills}\nPills per Day: ${pills[index].pillsPerDay}"),
                      title: Text(pills[index].name),
                    );
                  },
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
            backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return custom.BottomSheet(addPills: addPills);
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
