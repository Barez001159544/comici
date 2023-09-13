import 'package:flutter/cupertino.dart';

import '../models/hr_byid.dart';

class SingleHero extends ChangeNotifier{
  bool isLoading=false;
  late dynamic _singleHeroo;
  dynamic get singleHeroo=>_singleHeroo;
  void setSingleHero(dynamic hero){
    isLoading=true;
    notifyListeners();

    _singleHeroo= hero;

    isLoading=false;
    notifyListeners();
  }
}