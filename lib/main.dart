import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chefsysproject/pages/login.dart';
import 'package:chefsysproject/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RMS',
      theme: lightMode,
      darkTheme: darkMode,
      home: AnimatedSplashScreen(
          splash: Image(image: AssetImage('assets/logo.png')),
          duration: 1000,
          splashTransition: SplashTransition.rotationTransition,
          backgroundColor: Colors.white,
          nextScreen: Login()),
      /*Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.blue,
                ),
                Container(
                  child: Text(
                    'ChefSys',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: 'Indie',
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),*/

      //home: const Login(),
    );
  }
}
