import 'package:covidspyapp/utility/AdmobUtility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class NativeAdmobWidget extends StatelessWidget {
  final _nativeAdController = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    return NativeAdmob(
      adUnitID: AdmobUtility.getBannerAdUnitId(),
      controller: _nativeAdController,
      type: NativeAdmobType.full,
    );
  }
}
