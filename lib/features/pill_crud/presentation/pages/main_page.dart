import 'package:flutter/material.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/bottom_sheet_view_model.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/provider.dart';
import 'package:pill_tracker/features/pill_crud/presentation/widgets/bottom_sheet_widget.dart';
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
                            return ListTile(
                              leading: const Icon(Icons.medication_rounded),
                              subtitle: Text("ID: ${pills[index].id}"),
                              title: Text(pills[index].name),
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

// import 'package:flutter/material.dart';
//     as custom;

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   final List<PillEntity> pills = [
//     PillEntity(
//       name: 'Vitamin C',
//       numberOfPills: 30,
//       id: '0', // duzelt
//       pillsPerDay: 1,
//       startingDay: DateTime.now(),
//       endingDay: DateTime.now().add(const Duration(days: 30)),
//       type: '',
//       period: [],
//     ),
//     PillEntity(
//       name: 'Omega 3',
//       id: '1', // duzelt
//       numberOfPills: 60,
//       pillsPerDay: 2,
//       startingDay: DateTime.now(),
//       endingDay: DateTime.now().add(const Duration(days: 30)),
//       type: '',
//       period: [],
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     PillEntity addPills({
//       required String name,
//       required int numberOfPills,
//       required int pillsPerDay,
//     }) {
//       PillEntity pill = PillEntity(
//         name: name,
//         id: '123123', // duzelt
//       );
//       setState(() {
//         pills.add(pill);
//       });
//       return pill;
//     }

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Pill Tracker",
//           style: Theme.of(context).appBarTheme.titleTextStyle,
//         ),
//         foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
//         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//       ),
//       body: SizedBox(
//         height: double.infinity,
//         width: double.infinity,
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: pills.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       leading: const Icon(Icons.medication_rounded),
//                       subtitle: Text(
//                           "Number of Pills: ${pills[index].numberOfPills}\nPills per Day: ${pills[index].pillsPerDay}"),
//                       title: Text(pills[index].name),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         foregroundColor:
//             Theme.of(context).floatingActionButtonTheme.foregroundColor,
//         backgroundColor:
//             Theme.of(context).floatingActionButtonTheme.backgroundColor,
//         shape: Theme.of(context).floatingActionButtonTheme.shape,
//         onPressed: () {
//           showModalBottomSheet(
//             backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
//             context: context,
//             isScrollControlled: true,
//             builder: (context) {
//               return custom.BottomSheet(addPills: addPills);
//             },
//           );
//         },
//         child: Icon(Icons.add,
//             size: Theme.of(context).floatingActionButtonTheme.iconSize),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }
// }
