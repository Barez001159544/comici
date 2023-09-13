import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:superhero/constants.dart';
import 'package:superhero/controllers/hero_by_id_controller.dart';
import 'package:superhero/controllers/hero_by_name_controller.dart';
import 'package:superhero/controllers/theme.dart';
import 'package:superhero/models/hr_byid.dart';
import 'package:superhero/models/main_response.dart';
import 'package:superhero/screens/hero_screen.dart';
import 'package:superhero/screens/temp_screen.dart';

import '../characters/characters.dart';
import '../controllers/single_hero.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}
List images=[
  "DC_Comics_logo.svg.png",
  "Marvel-Comics-logo.png",
  "The-Boys-Logo-PNG-Clipart.png",
  "1200px-Hellboy-comic-logo.svg.png",
];
List cnames=[
  "DC Comics",
  "Marvel Comics",
  "The boys",
  "Hellboy",
];
List cColors=[
  bYellow,
  Color(0xff44C2D5),
  Color(0xff93efa4),
  Color(0xffD54474),
];
TextEditingController searchController= TextEditingController();
String value="";
class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HeroByIdController>(context, listen: false).returnedHero.isEmpty?Provider.of<HeroByIdController>(context, listen: false).getHeroes():print("Already Full");
      // Provider.of<HeroByIdController>(context, listen: false).favHeroes.isEmpty?Provider.of<HeroByIdController>(context, listen: false).getHeroesById():print("Already full of Favs");
      // Provider.of<HeroByNameController>(context, listen: false).getHeroes();
      // Provider.of<HeroByNameController>(context, listen: false).mainResponse==null?print("Waiting"):print("+++++++${Provider.of<HeroByNameController>(context, listen: false).mainResponse?.resultsFor}");
    });
  }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer4<HeroByIdController, SingleHero, HeroByNameController, TwoDiffTheme>(
        builder: (context, heroByIdController, singleHero, heroByNameController, twoDiffTheme, child){
          return Scaffold(
            backgroundColor: twoDiffTheme.isDark?bGrey1:bGrey,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              title: Center(
                child: Text("Find Your Superhero", style: TextStyle(fontFamily: "Comic", fontSize: 15, color: twoDiffTheme.isDark?Colors.white:Colors.black),),),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: wid,
                        height: 300,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index){
                              return Container(
                                width: 200,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: cColors[index],
                                  border: customBorder,
                                  boxShadow: customBoxShadow,
                                ),
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      child: Image.asset("images/${images[index]}", alignment: Alignment.bottomLeft,),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(cnames[index], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("American media and entertainment company", style: TextStyle(fontSize: 12,),)
                                  ],
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: twoDiffTheme.isDark?whiteGrey1:grey,
                          boxShadow: customBoxShadow,
                          border: customBorder,
                        ),
                        margin: EdgeInsets.all(30),
                        child: Center(
                          child: TextField(
                            controller: searchController,
                            onChanged: (val){
                              setState(() {
                                value=val;
                                heroByNameController.getHeroes("${searchController.text}");
                              });
                            },
                            onSubmitted: (val){
                              searchController.text==""?null:print("${searchController.text}");
                            },
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              icon: GestureDetector(
                                  onTap: (){
                                    // heroByNameController.getHeroes(searchController.text);
                                    searchController.text==""?null:print("${searchController.text}");
                                  },
                                  child: Icon(Icons.search, color: value==""?Colors.grey:Colors.white,)),
                              hintText: "Search",
                              hintStyle: TextStyle(color: Colors.grey,),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      (heroByIdController.isLoading && heroByIdController.returnedHero.isEmpty)?Container(
                        width: double.maxFinite,
                        height: 180,
                        color: Colors.transparent,
                        child: Center(
                          child: LoadingAnimationWidget.dotsTriangle(color: green, size: 50),
                        ),
                      ):
                      value==""?Column(
                        children: List.generate(heroByIdController.returnedHero.length, (index){
                          return GestureDetector(
                            onTap: (){
                              print("$index clicked");
                              // heroByIdController.setSingleHero();
                              singleHero.setSingleHero(heroByIdController.returnedHero[index]);  // .singleHeroo=heroByIdController.returnedHero;
                              // Navigator.of(context).pushAndRemoveUntil(
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) {
                              //       return TempScreen();
                              //     },
                              //   ),
                              //       (_) => false,
                              // );
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                                return HeroScreen();
                              }));
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
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      image: DecorationImage(
                                        image: NetworkImage(heroByIdController.returnedHero[index].imagee?.url==null?"https://www.google.com/url?sa=i&url=https%3A%2F%2Fdepositphotos.com%2Fvectors%2Fno-image-available.html&psig=AOvVaw1MCmD5ZgD2dnA4T-tUzZ8M&ust=1694213311294000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCPiL6MzKmYEDFQAAAAAdAAAAABAE":"${heroByIdController.returnedHero[index].imagee?.url}"),//NetworkImage("${heroesList[index]?.imagee?.url}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),        //${heroesList[index]?.name}
                                  Text("${heroByIdController.returnedHero[index].name}", style: TextStyle(fontSize: 18, color: twoDiffTheme.isDark?Colors.white:Colors.black, fontFamily: "Comic"),),
                                  Icon(Icons.chevron_right_rounded, color: twoDiffTheme.isDark?Colors.white:Colors.black,),
                                ],
                              ),
                            ),
                          );
                        }),
                      ):heroByNameController.isLoading?LoadingAnimationWidget.dotsTriangle(color: green, size: 40):Column(
                        children: List.generate(heroByNameController.isLoading?0:(heroByNameController.mainResponse!.results.length>5?5:heroByNameController.mainResponse!.results.length), (index){
                          return GestureDetector(
                            onTap: (){
                              print("$index clicked");
                              // heroByIdController.setSingleHero();
                              singleHero.setSingleHero(heroByNameController.mainResponse?.results[index]);  // .singleHeroo=heroByIdController.returnedHero;
                              // Navigator.of(context).pushAndRemoveUntil(
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) {
                              //       return TempScreen();
                              //     },
                              //   ),
                              //       (_) => false,
                              // );
                              Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (context){
                                return HeroScreen();
                              }));
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
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      image: DecorationImage(
                                        image: NetworkImage(heroByNameController.isLoading?"n":"${heroByNameController.mainResponse?.results[index].imagee?.url}"),//NetworkImage("${heroesList[index]?.imagee?.url}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),        //${heroesList[index]?.name}
                                  Text(heroByNameController.isLoading?"n":"${heroByNameController.mainResponse?.results[index].name}", style: TextStyle(fontSize: 18, color: twoDiffTheme.isDark?Colors.white:Colors.black, fontFamily: "Comic"),),
                                  Icon(Icons.chevron_right_rounded, color: twoDiffTheme.isDark?Colors.white:Colors.black,),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
