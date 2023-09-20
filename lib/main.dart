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

import 'controllers/connection_availability.dart';

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
      ChangeNotifierProvider(
        create: (context)=>InternetAvailability(),
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
  // Future<Widget> nextScreen() async {
  //   var prefs= await SharedPreferences.getInstance();
  //   bool? notFirstTime= await prefs.getBool("notFirstTime");
  //   print("---------${notFirstTime}");
  //   return Future.value(notFirstTime==false?LaunchScreen():HomeScreen());
  // }
  var ran;
  @override
  void initState() {
    super.initState();
    ran= Random().nextInt(8);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TwoDiffTheme>(context, listen: false).getDefaultTheme();
      Provider.of<HeroByIdController>(context, listen: false).getHeroes();
      Provider.of<InternetAvailability>(context, listen: false).checkInternet();
      print("(((((((${Provider.of<InternetAvailability>(context, listen: false).isLoading}");
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
      home: Consumer2<HeroByIdController, InternetAvailability>(
        builder: (context, heroByIdController, internetAvailability, child){
          return internetAvailability.isLoading?Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ):FlutterSplashScreen(
            defaultNextScreen: LaunchScreen(),
            duration: Duration(seconds: internetAvailability.availability?10:1000),
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
                internetAvailability.availability?Container():Center(
                  child: Container(
                    width: 200,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Center(child: Text("Not Internet Connection!", style: TextStyle(color: Colors.grey.shade700),))),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  ran= Random().nextInt(8);
                                  internetAvailability.checkInternet();
                                },
                                child: Container(
                                  height: 50,
                                  child: Center(child: Text("Try Again")),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.grey.shade700, width: 0.5, style: BorderStyle.solid),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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

