import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BlueContoller extends GetxController {
  Future scanDevices() async {
    if (await FlutterBluePlus.isSupported == false) {
      debugPrint('Nao suportado');
    }
    if (await Permission.bluetoothScan.request().isGranted) {
      if (await Permission.bluetoothConnect.request().isGranted) {
        FlutterBluePlus.startScan(
          continuousUpdates: true,
          androidUsesFineLocation: true,
          timeout: const Duration(seconds: 15),
        );
        // FlutterBluePlus.stopScan();
      }
    }
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
}
