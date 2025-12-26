import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';

import '../../main.dart';

Future<void> checkConnectivity({required BuildContext context}) async {
  Connectivity().onConnectivityChanged.listen((
    List<ConnectivityResult> results,
  ) {
    if (results.contains(ConnectivityResult.none)) {
      isNetworkConnected.value = false;
    } else {
      isNetworkConnected.value = true;
    }
    Logger.info("Network Connection : ${isNetworkConnected.value}");
  });
}
