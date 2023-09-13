import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:superhero/constants.dart';
import 'package:superhero/controllers/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}
List<IconData> aboutIcons=[
  FontAwesomeIcons.squareFacebook,
  FontAwesomeIcons.squareInstagram,
  FontAwesomeIcons.linkedin,
];


class _AboutScreenState extends State<AboutScreen> {

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPackageInfo();
  }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<TwoDiffTheme>(
        builder: (_, twoDiffTheme, child){
          return Scaffold(
            backgroundColor: twoDiffTheme.isDark?bGrey1:bGrey,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              leading: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
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
                child: Text("Adjust Your Superpowers", style: TextStyle(fontFamily: "Comic", fontSize: 15, color: twoDiffTheme.isDark?Colors.white:Colors.black),),),
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(_packageInfo.appName.isEmpty?"Unknown":"${_packageInfo.appName}", style: TextStyle(color: twoDiffTheme.isDark?Colors.grey.shade400:Colors.grey.shade600, fontWeight: FontWeight.bold),),
                        Text(_packageInfo.version.isEmpty?"Unknown":"${_packageInfo.version}", style: TextStyle(color: twoDiffTheme.isDark?Colors.grey.shade400:Colors.grey.shade600, fontWeight: FontWeight.bold)),
                        Text(_packageInfo.buildNumber.isEmpty?"Unknown":"${_packageInfo.buildNumber}", style: TextStyle(color: twoDiffTheme.isDark?Colors.grey.shade400:Colors.grey.shade600, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlutterLogo(
                              textColor: Colors.black,
                              size: 15,
                            ),
                            SizedBox(width: 6,),
                            Text("Barez Azad", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: twoDiffTheme.isDark?Colors.white:Colors.black),),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index){
                            return GestureDetector(
                              onTap: (){
                                if(index==0){
                                  _launchUrl('https://www.facebook.com/profile.php?id=100009746616856');
                                }else if(index==1){
                                  _launchUrl('https://www.instagram.com/barez_azad_1?fbclid=IwAR2jYMDW9e87fg2IGbSoJ676WwpcbSTYUsvh3BEZDtA9-wTw1GoIOosyslg');
                                }else{
                                  _launchUrl('https://www.linkedin.com/in/barez-azad-76066b27a/');
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                color: Colors.transparent,
                                child: Center(child: FaIcon(aboutIcons[index],color: twoDiffTheme.isDark?Colors.grey.shade400:Colors.black,)),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
Future<void> _launchUrl(String uri) async {
  final Uri url = Uri.parse(uri);
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}