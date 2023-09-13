import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superhero/controllers/hero_by_id_controller.dart';
import 'package:superhero/models/powerstats.dart';

// bool isDark=false;

Color green= Color(0xff4D824A);
Color grey= Color(0xff4B4B4B);
Color bGrey= Color(0xffE0E0E0);
Color bYellow= Color(0xffD5D544);
Color whiteGrey= Color(0xffCFCFCF);

Color green1= Color(0xff4D824A);
Color grey1= Color(0xffE0E0E0);
Color bGrey1= Color(0xff4B4B4B);
Color bYellow1= Color(0xffD5D544);
Color whiteGrey1= Color(0xff171717);

List powerstatsColors=[
  Color(0xffAF4646),
  Color(0xff54AF46),
  Color(0xff46AFAF),
  Color(0xff4666AF),
  Color(0xff8C46AF),
  Color(0xffD5D544),
];

List<BoxShadow> customBoxShadow=[
    BoxShadow(
      color: Colors.black,
      spreadRadius: 1,
      blurRadius: 3,
      offset: Offset(5, 5),
    ),
];

Border customBorder= Border.all(width: 1, color: Colors.black, style: BorderStyle.solid,);

List facts=[
  "Spider-Man’s web is faster than a bullet; in one situation, Spider-Man managed to web a gun as the trigger was pulled.",
  "Batman Beat Darkseid… Twice!",
  "Wolverine deubted as a Villain, but his status as a villain was short-lived.",
  "The gravitational force on Krypton is a lot higher than on Earth, so this makes inhabitants naturally stronger than a human raised on Earth.",
  "Iron Man actually owns Area 51 in the Marvel universe.",
  "Wonder Woman isn’t only super-strong, super-fast, and a skilled warrior. She also has healing powers, an enhanced sense of taste and smell and divine wisdom",
  "Black Adam Became Yellow Lantern, To become one, one must instill fear in the heart of his or her enemies.",
  "the Flash’s abilities to run millions of time faster than the speed of light, time travel, and even create alternate timelines.",
  "In a crossover between Batman & Captain America, Joker saves america from Red Skull.",
  "10",
];

List factBackground=[
  "HD-wallpaper-grunge-spiderman-amoled-dark-dc-comics-fighter-grunge-marvel-spider-spiderman-steamroom-superhero.jpg",
  "batman-dark-4k-4s.jpg",
  "FUqVgQ_XwAAVyO7.jpg",
  "49ff1d73f137c08f1ae8af1ffbe28004.jpg",
  "iron-man-logo-in-the-dark-kkkpop58t09l7w09.jpg",
  "bc9d00bb35a8b9d153959c135a7febe6.jpg",
  "2020-black-adam-4k-xo.jpg",
  "b4b8e08f7cda355a7c7b68cf823f37a3.jpg",
  "e95485b9dcf5acf85529a80bd4c85079.png",
  "",
];

List powerstatsKeys=[
  "intelligence",
  "strength",
  "speed",
  "durability",
  "power",
  "combat",
];

Widget heroInfo(IconData icon, String info, Color color){
  return Padding(
    padding: EdgeInsets.only(left: 30),
    child: Row(
      children: [
        FaIcon(icon, size: 25, color: color,),
        SizedBox(
          width: 10,
        ),
        Text("$info", style: TextStyle(fontFamily: "Comic", fontSize: 15, color: color)),
      ],
    ),
  );
}

Widget heroListData(String title, String data, Color textColor, Color backgroundColor){

  List<String> splitCSVW(String input){
    List<String> withoutCommas=[];
    bool delete=false;
    for(int loop=0; loop<input.length; loop++) {
      if( input[loop]=='(' )
        delete = true;
      else if( input[loop]==')' )
    delete = false;

    if( !delete && input[loop]==',' ){
      withoutCommas.add("|");
    }else{
      withoutCommas.add(input[loop]);
    }
    }
    String result="";
    for(int i=0; i<withoutCommas.length; i++){
      result+=withoutCommas[i];
    }
    print(result);
    return result.split("|");
  }
  List<String> datas=splitCSVW(data);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding:EdgeInsets.only(left: 30),
          child: Text("$title:", style: TextStyle(fontFamily: "Comic", fontSize: 15, color: textColor))),
      SizedBox(
        height: 20,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
              datas.length, (index) {
            return Container(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              // width: 200,
              height: 46,
              decoration: BoxDecoration(
                color: backgroundColor,
                border: customBorder,
                boxShadow: customBoxShadow,
              ),
              margin: EdgeInsets.only(right: 20, bottom: 10, left: index==0?30:0),
              padding: EdgeInsets.only(left: 10, right: 30),
              child: Text(datas[index], style: TextStyle(color: textColor, fontFamily: "Comic", fontSize: 15, height: 3),),
            );
          }),
        ),
      ),
    ],
  );
}

