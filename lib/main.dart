import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_sample_record_and_play_mic/pages/home.dart';
import 'package:get/get.dart';

/// inicialização do aplicativo
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// chamada inicial do aplicativo
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      defaultTransition: Transition.native,
      title: 'Flutter Record and Play',
      getPages: [
        GetPage(
            name: '/home',
            page: () => HomePage()
        ),
      ],
    );
  }
}
