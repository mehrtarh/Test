import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:job/app/app_model.dart';
import 'package:job/pages/login/login_view.dart';
import 'package:job/presentation/fonts_value.dart';
import 'package:overlay_support/overlay_support.dart';



GetIt getIt = GetIt.instance;

void main() {
  runApp(MyApp());
  getIt.registerSingleton<AppModel>(AppModelImplementation(),
      signalsReady: true);
}
// =>

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    return OverlaySupport(child: MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
        );
      },
      title: 'Technical Test',

      theme: ThemeData(
        fontFamily: FontsValue.fontFamily,
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(),
      home: LoginView(),
    ));
  }
}
