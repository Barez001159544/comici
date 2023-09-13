import 'dart:math';
import 'package:provider/provider.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superhero/constants.dart';
import 'package:superhero/controllers/hero_by_id_controller.dart';
import 'package:superhero/controllers/hero_by_name_controller.dart';
import 'package:superhero/controllers/single_hero.dart';
import 'package:superhero/controllers/theme.dart';
import 'package:superhero/screens/hero_screen.dart';
import 'package:superhero/screens/home_screen.dart';
import 'package:superhero/screens/launch_screen.dart';

void main() {
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context)=>HeroByIdController(),
      ),
      ChangeNotifierProvider(
          create: (context)=>SingleHero(),
      ),
      ChangeNotifierProvider(
        create: (context)=>HeroByNameController(),
      ),
      ChangeNotifierProvider(
          create: (context)=>TwoDiffTheme(),
      ),
    ],
      child: MyApp(),
  ),);
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var ran;
  @override
  void initState() {
    super.initState();
    ran= Random().nextInt(8);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TwoDiffTheme>(context, listen: false).getDefaultTheme();
    });
  }
  @override
  void dispose() {
    ran=0;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print(ran);
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterSplashScreen(
        defaultNextScreen: HomeScreen(),
        splashScreenBody: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/${factBackground[ran]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: Container(
                height: 200,
                width: wid,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/pngtree-torn-paper-yellow-and-black-abstract-image_764054.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Container(
                      width: wid-80,
                      height: 120,
                      child: Center(child: Text(textAlign: TextAlign.center,"${facts[ran]}", style: TextStyle(color: Colors.white, fontFamily: "Comic"),))),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              child: Container(
                  width: wid,
                  child: Center(child: Text("Loading...", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),))),
            ),
          ],
        ),
        duration: Duration(seconds: 5),
      ),
      // Container(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage("images/b4b8e08f7cda355a7c7b68cf823f37a3.jpg"),
      //       fit: BoxFit.cover,
      //     )
      //   ),
      // ),
    );
  }
}
