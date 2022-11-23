import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goodtech/utility/app_dialog.dart';
import 'package:goodtech/widgets/widget_text_button.dart';

class AppService {
  Future<void> processCreateNewAccount({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => null)
        .catchError((onError) {});
  }

  Future<Position?> processFindPosition({required BuildContext context}) async {
    Position? position;
    bool locationServiceEnable = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    if (locationServiceEnable) {
      //Open Service

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        //ไม่อนุญาติเลย
        dialogOpenPermission(context);
      } else {
        if (permission == LocationPermission.denied) {
          //ยังไม่รู้
          permission = await Geolocator.requestPermission();
          if ((permission != LocationPermission.whileInUse) &&
              (permission != LocationPermission.always)) {
            //Denied Forver
            dialogOpenPermission(context);
          } else {
            position = await Geolocator.getCurrentPosition();
          }
        } else {
          position = await Geolocator.getCurrentPosition();
        }
      }
    } else {
      // Off Service
      AppDialog(context: context).normalDialog(
          title: 'Off Location ?',
          detail: 'กรุณาเปิด Location Service',
          secondBotton: WidgetTextButton(
            label: 'กรุณาเปิด Location',
            pressFunc: () {
              Geolocator.openLocationSettings();
              exit(0);
            },
          ));
    }

    return position;
  }

  void dialogOpenPermission(BuildContext context) {
    AppDialog(context: context).normalDialog(
        title: 'ไม่อนุญาติแชร์พิกัด ?>',
        detail: 'กรุณา อนุญาติแชร์พิกัดด้วย',
        secondBotton: WidgetTextButton(
          label: 'อนุญาติ แชร์พิกัด',
          pressFunc: () {
            Geolocator.openAppSettings();
            exit(0);
          },
        ));
  }
}