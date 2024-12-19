import 'package:flutter/material.dart';
import 'package:pill_tracker/core/configs/constants/routes.dart';
import 'package:pill_tracker/core/configs/theme/app_themes.dart';
import 'package:pill_tracker/features/pill_crud/presentation/pages/main_page.dart';
import 'package:pill_tracker/features/pill_crud/presentation/pages/splash_page.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PillProvider(),
        )
      ],
      child: MaterialApp(
        routes: {
          mainPageRoute: (context) => const MainPage(),
        },
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        home: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashPage();
  }
}

// import 'package:flutter/material.dart';
// import 'package:pill_tracker/domain/entities/pill_entity.dart';
// import 'package:pill_tracker/presentation/provider/provider.dart';
// import 'package:provider/provider.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ChangeNotifierProvider(
//         create: (context) => PillProvider(),
//         child: Builder(
//           builder: (context) => Scaffold(
//             appBar: AppBar(title: const Text('Add Pill')),
//             body: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () async {
//                       final pillProvider = context.read<PillProvider>();
//                       final pill = PillEntity(name: 'Lil', id: "125");
//                       await pillProvider.addPill(pill);

//                       pillProvider.failure != null
//                           ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                               content: Text(
//                                   'Failed to add pill: ${pillProvider.failure?.errorMessage}')))
//                           : ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text('Pill added successfully')));
//                     },
//                     child: const Text("Add Pill"),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final pillProvider = context.read<PillProvider>();
//                       const pillId = '111111';
//                       await pillProvider.getPillById(pillId);

//                       pillProvider.failure != null
//                           ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                               content: Text(
//                                   'Failed to get pill: ${pillProvider.failure?.errorMessage}')))
//                           : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                               content: Text(
//                                   'Pill fetched: ${pillProvider.pill?.name}')));
//                     },
//                     child: const Text("Get Pill by ID"),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final pillProvider = context.read<PillProvider>();
//                       pillProvider.getAllPills();

//                       pillProvider.failure != null
//                           ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                               content: Text(
//                                   'Failed to get pills: ${pillProvider.failure?.errorMessage}')))
//                           : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                               content: Text(
//                                   'Number of pills: ${pillProvider.pills?.length}')));
//                     },
//                     child: const Text("Get all pills"),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final pillProvider = context.read<PillProvider>();
//                       pillProvider.removePill("125");

//                       pillProvider.failure != null
//                           ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                               content: Text(
//                                   'Failed to remove pill: ${pillProvider.failure?.errorMessage}')))
//                           : ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text('Removed pill successfully')));
//                     },
//                     child: const Text("Remove Pill by ID"),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
