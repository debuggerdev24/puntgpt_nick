import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puntgpt_nick/punt_gpt_app.dart';
import 'package:puntgpt_nick/services/storage/locale_storage_service.dart';
import 'package:toastification/toastification.dart';

ValueNotifier<bool> isNetworkConnected = ValueNotifier(true);
bool isGuest = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Future.wait([LocaleStorageService.init()]);
  runApp(ToastificationWrapper(child: const PuntGPT()));
}
/*
http://192.168.1.100:5000
flutter run --release -d web-server --web-port=5000 --web-hostname=0.0.0.0
-> Worked on fix the issue of wring secion's story displaying in another bookie.
-> Worked on fixed minor bugs in the story section and improve UX.
-> Worked on added new section for the preview comments.
-> Worked on update the UI of tip slip and punters club by adding refesh indicator.
-> Worked on debug the app store rejection issue and fix the subscription regarding issues. 
->  uploaded new build for review to the app store.



I have share the app for review in app store, If you are approving the current app then I will update the app on play store, if need any change then tell me so before review I uplaoding for review on play store I can perform it.

*/