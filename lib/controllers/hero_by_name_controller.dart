import 'package:flutter/cupertino.dart';
import 'package:superhero/characters/characters.dart';
import 'package:superhero/models/main_response.dart';

class HeroByNameController extends ChangeNotifier{
  var service= GetCharacters();
  bool isLoading=false;

  MainResponse? _mainResponse;
  MainResponse? get mainResponse=>_mainResponse;

  void getHeroes(String name) async{
    isLoading=true;
    notifyListeners();

    var response= await service.getByName("$name");
    print(response?.resultsFor);
    _mainResponse=response!;

    isLoading=false;
    notifyListeners();
  }
}