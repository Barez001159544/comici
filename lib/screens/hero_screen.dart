import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superhero/constants.dart';
import 'package:superhero/controllers/hero_by_id_controller.dart';
import 'package:superhero/controllers/single_hero.dart';
import 'package:superhero/controllers/theme.dart';
import 'package:superhero/models/hr_byid.dart';
import 'package:superhero/screens/start_screen.dart';

class HeroScreen extends StatefulWidget {
  const HeroScreen({super.key});

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

// late bool isItFav=false;
class _HeroScreenState extends State<HeroScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // ()async{
      //   var prefs= await SharedPreferences.getInstance();
      //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //       print(Provider.of<SingleHero>(context, listen: false).singleHeroo.name);
      //       isItFav= prefs.containsKey(Provider.of<SingleHero>(context, listen: false).singleHeroo.name!);
      //     });
      // }();
      // (()async{
      //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //     print(Provider.of<SingleHero>(context, listen: false).singleHeroo.name);
      //   });
      // }());
    });
  }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer3<HeroByIdController, SingleHero, TwoDiffTheme>(
        builder: (_,heroByIdController, singleHero, twoDiffTheme, child){
          // setState(() {
          //   isItFav= prefs.containsKey("${singleHero.singleHeroo.name}");
          // });

          List powerstatsFinal=[
            singleHero.singleHeroo.powerstats?.intelligence!="null"?singleHero.singleHeroo.powerstats?.intelligence:"0",
            singleHero.singleHeroo.powerstats?.strength!="null"?singleHero.singleHeroo.powerstats?.strength:"0",
            singleHero.singleHeroo.powerstats?.speed!="null"?singleHero.singleHeroo.powerstats?.speed:"0",
            singleHero.singleHeroo.powerstats?.durability!="null"?singleHero.singleHeroo.powerstats?.durability:"0",
            singleHero.singleHeroo.powerstats?.power!="null"?singleHero.singleHeroo.powerstats?.power:"0",
            singleHero.singleHeroo.powerstats?.combat!="null"?singleHero.singleHeroo.powerstats?.combat:"0",
            // singleHero.singleHeroo.powerstats?.intelligence,
            // singleHero.singleHeroo.powerstats?.strength,
            // singleHero.singleHeroo.powerstats?.speed,
            // singleHero.singleHeroo.powerstats?.durability,
            // singleHero.singleHeroo.powerstats?.power,
            // singleHero.singleHeroo.powerstats?.combat,
          ];
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: twoDiffTheme.isDark?bGrey1:bGrey,
              leading: GestureDetector(
                onTap: (){
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) {
                  //       return StartScreen();
                  //     },
                  //   ),
                  //       (_) => true,
                  // );
                  Navigator.pop(context);
                  print("BACK");
                },
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Icon(Icons.keyboard_arrow_left_rounded, color: twoDiffTheme.isDark?Colors.white:Colors.black, size: 25,),
                  ),
                ),
              ),
              title: Center(
                child: Text("${singleHero.singleHeroo.name}", style: TextStyle(fontFamily: "Comic", fontSize: 15, color: twoDiffTheme.isDark?Colors.white:Colors.black,),),
              ),
              actions: [
                GestureDetector(
                  onTap: (){
                    (() async{
                      var prefs= await SharedPreferences.getInstance();
                      // prefs.clear();
                      //write
                      saveFavHeroes(String heroId) async {
                        await prefs.setString("${singleHero.singleHeroo.name}", "${heroId}");
                      }
                      setState(() {
                        prefs.containsKey("${singleHero.singleHeroo.name}")?prefs?.remove("${singleHero.singleHeroo.name}"):saveFavHeroes("${singleHero.singleHeroo.id}");
                        heroByIdController.favHeroesIds.contains(singleHero.singleHeroo.id)?heroByIdController.favHeroesIds.remove(singleHero.singleHeroo.id):heroByIdController.favHeroesIds.add(singleHero.singleHeroo.id);
                        heroByIdController.favHeroes.contains(singleHero.singleHeroo)?heroByIdController.favHeroes.remove(singleHero.singleHeroo):heroByIdController.favHeroes.add(singleHero.singleHeroo);
                        // isItFav=prefs.containsKey("${singleHero.singleHeroo.name}")?true:false;
                      });
                      //read
                      Future<String?> readFavHeroes() async {
                        print(prefs.getKeys());
                        print(await prefs.getString("${singleHero.singleHeroo.name}"));
                        return await prefs.getString("${singleHero.singleHeroo.name}");
                      }
                      readFavHeroes();
                    }());
                    print("FAV");
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Icon(heroByIdController.favHeroesIds.contains(singleHero.singleHeroo.id)?Icons.favorite_rounded:Icons.favorite_border_rounded, color:heroByIdController.favHeroesIds.contains(singleHero.singleHeroo.id)?Colors.red:(twoDiffTheme.isDark?Colors.white:Colors.black), size: 25,),
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: twoDiffTheme.isDark?bGrey1:bGrey,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: wid*0.7,
                            height: 400,
                            margin: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("${singleHero.singleHeroo.imagee?.url}"),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: customBoxShadow,
                              border: customBorder,
                            ),
                          ),
                          Positioned(
                            top: 30,
                            right: 10,
                            child: GestureDetector(
                              onTap: (){
                                // (() async{
                                //   await ImageDownloader.downloadImage(singleHero.singleHeroo.imagee!.url!);
                                // }());
                                print("Download");
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(Icons.file_download_outlined, color: Colors.white, size: 15,),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    heroInfo(FontAwesomeIcons.globe, "${singleHero.singleHeroo.biography?.publisher}", twoDiffTheme.isDark?Colors.white:Colors.black),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: List.generate(6, (index) {
                          return Stack(
                            children: [
                              Container(
                                height: 40,
                                margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  color: twoDiffTheme.isDark?whiteGrey1:whiteGrey,
                                  border: customBorder,
                                  boxShadow: customBoxShadow,
                                ),
                              ),
                              Container(
                                width: (wid-60)*(double.parse(powerstatsFinal[index])/100),
                                height: 40,
                                margin: EdgeInsets.only(top: 20,),
                                decoration: BoxDecoration(
                                  color: powerstatsColors[index],
                                  border: customBorder,
                                ),
                              ).animate().scaleX(alignment: Alignment.centerLeft,duration: Duration(seconds: 1), curve: Curves.easeInOut,),
                              Container(
                                width: (wid-60),
                                height: 40,
                                margin: EdgeInsets.only(top: 20,),
                                child: Center(child: Text("${powerstatsKeys[index]}: ${powerstatsFinal[index]}", style: TextStyle(fontFamily: "Comic", fontSize: 15, color: Colors.white),)),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                        child: heroInfo(FontAwesomeIcons.userLarge, "${singleHero.singleHeroo.biography?.fullName}, ${singleHero.singleHeroo.appearance?.gender}, ${singleHero.singleHeroo.appearance?.race}", twoDiffTheme.isDark?Colors.white:Colors.black)),
                    SizedBox(
                      height: 40,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                        child: heroInfo(FontAwesomeIcons.cakeCandles, "${singleHero.singleHeroo.biography?.placeOfBirth}", twoDiffTheme.isDark?Colors.white:Colors.black)),
                    SizedBox(
                      height: 40,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                        child: heroInfo(FontAwesomeIcons.weightScale, "${singleHero.singleHeroo.appearance?.height[0]}\" : ${singleHero.singleHeroo.appearance?.height[1]}, ${singleHero.singleHeroo.appearance?.weight[0]} : ${singleHero.singleHeroo.appearance?.weight[1]}", twoDiffTheme.isDark?Colors.white:Colors.black)),
                    SizedBox(
                      height: 40,
                    ),
                    heroListData("Group Affiliation", singleHero.singleHeroo.connections!.groupAffiliation!, twoDiffTheme.isDark?Colors.white:Colors.black, twoDiffTheme.isDark?whiteGrey1:whiteGrey),  //singleHero.singleHeroo.connections?.groupAffiliation?.split(",") as List<dynamic>
                    SizedBox(
                      height: 30,
                    ),
                    heroListData("Relatives", singleHero.singleHeroo.connections!.relatives!, twoDiffTheme.isDark?Colors.white:Colors.black, twoDiffTheme.isDark?whiteGrey1:whiteGrey),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

