import 'package:flutter/material.dart';
import 'package:superhero/constants.dart';
import 'package:superhero/screens/favorite_screen.dart';
import 'package:superhero/screens/settings_screen.dart';
import 'package:superhero/screens/start_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
List images=[
  "DC_Comics_logo.svg.png",
  "Marvel-Comics-logo.png",
];
TextEditingController searchController= TextEditingController();
String value="";
List<Widget> screens=[
  StartScreen(),
  FavoriteScreen(),
  SettingsScreen(),
];
int selectedIndex=0;
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: bGrey,
        bottomNavigationBar: Container(
          width: wid,
          height: 60,
          color: grey,
          // padding: EdgeInsets.only(right: 150),
          child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 180,
                    child: BottomNavigationBar(
                      elevation: 0,
                      currentIndex: selectedIndex,
                      backgroundColor: Colors.transparent,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      selectedIconTheme: IconThemeData(color: Colors.white),
                      unselectedIconTheme: IconThemeData(color: Colors.grey),
                      items: [
                        BottomNavigationBarItem(icon: Icon(Icons.home, size: 23,), label: "Home", tooltip: "Home"),
                        BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded, size: 23,), label: "Fav", tooltip: "Favorites"),
                        BottomNavigationBarItem(icon: Icon(Icons.settings, size: 23,), label: "Settings", tooltip: "Settings"),
                      ],
                      onTap: (index){
                        print(index);
                        setState(() {
                          selectedIndex=index;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
        ),
        body: screens[selectedIndex],
      ),
    );
  }
}
