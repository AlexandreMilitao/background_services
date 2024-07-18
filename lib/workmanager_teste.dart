// import 'package:flutter/material.dart';
// import 'package:workmanager/workmanager.dart';

// const task = "firsttask";

// sendDate() {
//   print("Teste");
// }

// void callBackGroundService() {
//   Workmanager().executeTask((taskName, inputData) {
//     switch (taskName) {
//       case "firsttask":
//         sendDate();
//         break;
//       default:
//     }
//     return Future.value(true);
//   });
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Workmanager().initialize(
//     callBackGroundService,
//     isInDebugMode: true,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await Workmanager().registerPeriodicTask(
//               DateTime.now().second.toString(),
//               task,
//               frequency: const Duration(minutes: 5),
//               constraints: Constraints(networkType: NetworkType.connected),
//             );
//           },
//           child: const Text("Teste"),
//         ),
//       ),
//     );
//   }
// }
