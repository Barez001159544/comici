import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetAvailability extends ChangeNotifier{
  bool isLoading=true;
  bool _availability=false;
  bool get availability=>_availability;
  void checkInternet()async{
    isLoading=true;
    notifyListeners();
    final connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.wifi){
      _availability=true;
    }else if(connectivityResult==ConnectivityResult.mobile){
      _availability=true;
    }else if(connectivityResult==ConnectivityResult.none){
      _availability=false;
    }
    isLoading=false;
    notifyListeners();
  }
}