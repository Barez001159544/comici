import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:superhero/constants.dart';
import 'package:superhero/controllers/hero_by_id_controller.dart';
import 'package:superhero/controllers/single_hero.dart';

import '../controllers/theme.dart';
import 'hero_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Provider.of<HeroByIdController>(context, listen: false).returnedHero.isEmpty?Provider.of<HeroByIdController>(context, listen: false).getHeroes():print("Already Full");
      Provider.of<HeroByIdController>(context, listen: false).favHeroes.isEmpty?Provider.of<HeroByIdController>(context, listen: false).getHeroesById():print("Already full of Favs");
    });
  }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer3<HeroByIdController, SingleHero, TwoDiffTheme>(
        builder: (context, heroByIdController, singleHero, twoDiffTheme, child){
          return Scaffold(
            backgroundColor: twoDiffTheme.isDark?bGrey1:bGrey,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              title: Center(
                child: Text("Find Your Superhero", style: TextStyle(fontFamily: "Comic", fontSize: 15, color:twoDiffTheme.isDark?Colors.white:Colors.black),),),
            ),
            body: SafeArea(
              child: (heroByIdController.isLoading)?Container(
                width: double.maxFinite,
                height: 180,
                child: Center(
                  child: LoadingAnimationWidget.dotsTriangle(color: green, size: 50),
                ),
              ):heroByIdController.favHeroes.isEmpty?Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.codepen, color: Colors.grey.shade600, size: 100,),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Empty!", style: TextStyle(color: Colors.grey.shade600),),
                  ],
                ),
              ):ListView.builder(
                itemCount: heroByIdController.favHeroes.length,
                  itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    print("$index clicked");
                    // heroByIdController.setSingleHero();
                    singleHero.setSingleHero(heroByIdController.favHeroes[index]);  // .singleHeroo=heroByIdController.returnedHero;
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
                    margin: EdgeInsets.only(bottom: 20, right: 15, left: 15, top: index==0?10:0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            image: DecorationImage(
                              image: heroByIdController.favHeroes[index].imagee?.url==null?NetworkImage("https://www.google.com/url?sa=i&url=https%3A%2F%2Fdepositphotos.com%2Fvectors%2Fno-image-available.html&psig=AOvVaw1MCmD5ZgD2dnA4T-tUzZ8M&ust=1694213311294000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCPiL6MzKmYEDFQAAAAAdAAAAABAE"):NetworkImage("${heroByIdController.favHeroes[index].imagee?.url}"),//NetworkImage("${heroesList[index]?.imagee?.url}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),        //${heroesList[index]?.name}
                        Text("${heroByIdController.favHeroes[index].name}", style: TextStyle(fontSize: 18, color: twoDiffTheme.isDark?Colors.white:Colors.black, fontFamily: "Comic"),),
                        Icon(Icons.chevron_right_rounded, color: twoDiffTheme.isDark?Colors.white:Colors.black,),
                      ],
                    ),
                  ),
                );
              })
              // Column(
              //   children: List.generate(4, (index){
              //     return GestureDetector(
              //       onTap: (){
              //         print("$index clicked");
              //         // heroByIdController.setSingleHero();
              //         singleHero.setSingleHero(heroByIdController.returnedHero[index]);  // .singleHeroo=heroByIdController.returnedHero;
              //         // Navigator.of(context).pushAndRemoveUntil(
              //         //   MaterialPageRoute(
              //         //     builder: (BuildContext context) {
              //         //       return TempScreen();
              //         //     },
              //         //   ),
              //         //       (_) => false,
              //         // );
              //         Navigator.of(context).push(MaterialPageRoute(builder: (context){
              //           return HeroScreen();
              //         }));
              //       },
              //       child: Container(
              //         width: wid-30,
              //         height: 60,
              //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //         decoration: BoxDecoration(
              //           color: whiteGrey,
              //           border: customBorder,
              //           boxShadow: customBoxShadow,
              //         ),
              //         margin: EdgeInsets.only(bottom: 20),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Container(
              //               width: 40,
              //               height: 50,
              //               decoration: BoxDecoration(
              //                 color: Colors.blueAccent,
              //                 image: DecorationImage(
              //                   image: heroByIdController.returnedHero[index].imagee?.url==null?NetworkImage("https://www.google.com/url?sa=i&url=https%3A%2F%2Fdepositphotos.com%2Fvectors%2Fno-image-available.html&psig=AOvVaw1MCmD5ZgD2dnA4T-tUzZ8M&ust=1694213311294000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCPiL6MzKmYEDFQAAAAAdAAAAABAE"):NetworkImage("${heroByIdController.returnedHero[index].imagee?.url}"),//NetworkImage("${heroesList[index]?.imagee?.url}"),
              //                   fit: BoxFit.cover,
              //                 ),
              //               ),
              //             ),        //${heroesList[index]?.name}
              //             Text("${heroByIdController.returnedHero[index].name}", style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: "Comic"),),
              //             Icon(Icons.chevron_right_rounded, color: Colors.black,),
              //           ],
              //         ),
              //       ),
              //     );
              //   }),
              // ),
            ),
          );
        },
      ),
    );
  }
}
