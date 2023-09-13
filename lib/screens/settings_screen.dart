import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superhero/constants.dart';
import 'package:superhero/controllers/hero_by_id_controller.dart';
import 'package:superhero/controllers/theme.dart';
import 'package:superhero/screens/about_app_screen.dart';
import 'package:superhero/screens/launch_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer2<TwoDiffTheme, HeroByIdController>(
        builder: (context, twoDiffTheme, heroByIdController, child){
          List<String> setTitles=[
            twoDiffTheme.isDark?"Dark Knight":"White Queen",
            "Remove Favorites",
            "About",
          ];
          List<IconData> setIcons=[
            twoDiffTheme.isDark?Icons.dark_mode_rounded:Icons.light_mode_rounded,
            Icons.heart_broken_rounded,
            Icons.info_rounded,
          ];
          return Scaffold(
            backgroundColor: twoDiffTheme.isDark?bGrey1:bGrey,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              title: Center(
                child: Text("Adjust Your Superpowers", style: TextStyle(fontFamily: "Comic", fontSize: 15, color: twoDiffTheme.isDark?Colors.white:Colors.black),),),
            ),
            body: SafeArea(
                child: ListView.builder(
                    itemCount: setIcons.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: ()async{
                          if(index==0){
                            twoDiffTheme.changeTheme();
                          }else if(index==1) {
                            var prefs= await SharedPreferences.getInstance();
                            prefs.clear();
                            heroByIdController.favHeroes.clear();
                            heroByIdController.favHeroesIds.clear();
                          }else{
                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                              return AboutScreen();
                            }));
                          }
                        },
                        child: Container(
                          width: wid-30,
                          height: 60,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: twoDiffTheme.isDark?whiteGrey1:whiteGrey,
                            border: customBorder,
                            boxShadow: customBoxShadow,
                          ),
                          margin: EdgeInsets.only(bottom: 20, right: 15, left: 15, top: index==0?10:0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 40,
                                height: 50,
                                child: Center(
                                  child: Icon(setIcons[index], color: twoDiffTheme.isDark?Colors.white:Colors.black,),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),//${heroesList[index]?.name}
                              Text("${setTitles[index]}", style: TextStyle(fontSize: 18, color: twoDiffTheme.isDark?Colors.white:Colors.black, fontFamily: "Comic"),),
                            ],
                          ),
                        ),
                      );
                    })
            ),
          );
        },
      ),
    );
  }
}
