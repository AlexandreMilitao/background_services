import 'package:background_serrvices/service/back_service.dart';
import 'package:background_serrvices/service/bluetooth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  await Permission.notification.isDenied.then((value) {
    (value) {
      if (value) {
        Permission.notification.request();
      }
    };
  });
  await initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = "Stop service";

  final BlueContoller controller = BlueContoller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<BlueContoller>(
          init: BlueContoller(),
          builder: (BlueContoller controller) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        FlutterBackgroundService().invoke('setAsForeground');
                      },
                      child: const Text("Foreground"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        FlutterBackgroundService().invoke('setAsBackground');
                      },
                      child: const Text("Background"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final service = FlutterBackgroundService();
                        bool isRunning = await service.isRunning();
                        if (isRunning) {
                          service.invoke('stopService');
                        } else {
                          service.startService();
                        }
                        if (!isRunning) {
                          text = "Stop Service";
                        } else {
                          text = "Start Service";
                        }
                        setState(() {});
                      },
                      child: Text(text),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.scanDevices();
                      },
                      child: const Text('Scan Bluetooth'),
                    ),
                    StreamBuilder<List<ScanResult>>(
                      stream: controller.scanResults,
                      builder: (context, snapshot) {
                        debugPrint(snapshot.hasData.toString());
                        debugPrint(snapshot.data.toString());
                        debugPrint(snapshot.data?.length.toString());
                        debugPrint(snapshot.data?.isNotEmpty.toString());
                        if (snapshot.hasData && snapshot.data?.isNotEmpty == true) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data![index];
                                return Card(
                                  color: Colors.yellow,
                                  child: ListTile(
                                    title: Text(data.device.platformName),
                                    subtitle: Text(data.device.remoteId.str),
                                    trailing: Text(data.rssi.toString()),
                                  ),
                                );
                              });
                        } else {
                          return const Text("Vazio");
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
