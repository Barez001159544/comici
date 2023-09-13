import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superhero/characters/characters.dart';
import 'package:superhero/models/hr_byid.dart';

class HeroByIdController extends ChangeNotifier{
  final service= GetCharacters();
  bool isLoading=false;
  List<HRById> _returnedHero=[];
  List<HRById> get returnedHero=> _returnedHero;
  void getHeroes()async{
    isLoading=true;
    notifyListeners();
    _returnedHero=[];
    for(int i=0; i<10; i++){
      var response= await service.getById("${Random().nextInt(731)}");
      _returnedHero.add(response!);
    }

    isLoading=false;
    notifyListeners();
  }

  bool isFavLoading=false;
  List<dynamic> _favHeroes=[];
  List<dynamic> get favHeroes=> _favHeroes;
  List<String> _favHeroesIds=[];
  List<String> get favHeroesIds=> _favHeroesIds;
  void getHeroesById()async{
    isFavLoading=true;
    notifyListeners();

    List<dynamic> ids=[];
    var prefs= await SharedPreferences.getInstance();
    // print(prefs.getKeys());
    for(int i=0; i<prefs.getKeys().length; i++){
      if(prefs.getKeys().elementAt(i)=="isDark" || prefs.getKeys().elementAt(i)=="notFirstTime"){
        // Skip!
      }else{
        ids.add(prefs.getString(prefs.getKeys().elementAt(i)));
      }
    }
    // print(ids);
    for(int i=0; i<ids.length; i++){
      // var response= await service.getById("${ids[i]}");
        var response= await service.getById("${ids[i]}");
        _favHeroesIds.add(ids[i]);
        _favHeroes.add(response!);
    }
    print(_favHeroesIds);
    print(_favHeroes);
    isFavLoading=false;
    notifyListeners();
  }
}