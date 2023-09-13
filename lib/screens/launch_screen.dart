import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superhero/constants.dart';
import 'package:superhero/screens/home_screen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}
List images=[
  "marvelvsdclaunch-modified",
  "marvellaunch-modified",
  "dclaunch-modified",
];
PageController pageController= PageController();
int ind=0;
class _LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                onPageChanged: (index){
                  setState(() {
                    ind=index;
                  });
                },
                controller: pageController,
                  itemCount: 3,
                  itemBuilder: (context, index){
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/${images[index]}.jpg",),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: (index==0 || index==2)?0:null,
                            top: index==0?(hei+100)/2:(index==1?(hei-300)/2:hei/2),
                            right: index==1?0:null,
                            child: Container(
                              width: 250,
                              height: 143,
                              color: index==1?Colors.white:grey,
                              padding: EdgeInsets.only(left: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                  child: Text(index==0?"More than 700\ncharacters from\nboth universe.":(index==1?"Including Villains\nand Superheroes.":"Work, powerstats, biography & more."), style: TextStyle(color: index==1?grey:Colors.white, fontFamily: "Comic", fontSize: 25),)),
                            ),
                          ),
                          index==2?Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Center(
                                child: GestureDetector(
                                  onTap: (){
                                    print("END");
                                  },
                                  child: GestureDetector(
                                        onTap: ()async{
                                      var prefs = await SharedPreferences.getInstance();
                                      prefs.setBool("notFirstTime", true);
                                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context){
                                        return HomeScreen();
                                      }));
                                    },
                                    child: Container(
                                      height:82,
                                      width:343,
                                      margin: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color:Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(7),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(5, 5),
                                          ),
                                        ],
                                        border: Border.all(
                                          width: 1, color: Colors.black, style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: Center(child: Text("Continue", style: TextStyle(color: Colors.black, fontFamily: "Comic", fontSize: 20),)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ):Container(),
                        ],
                      ),
                    );
                      Image.asset('images/${images[index]}.jpg', fit: BoxFit.cover,);
                  }),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: (){
                    pageController.page!=2?pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ):print("END");
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    color: green,
                    child: Center(
                      child: Text("Next", style: TextStyle(fontFamily: "Comic", color: Colors.white),),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 10,
                child: Column(
                  children: List.generate(3, (i) {
                    return Container(
                      width: 10,
                      height: i==ind?25:10,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 4),
                    );
                  }),
                ),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Center(
              //       child:
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
