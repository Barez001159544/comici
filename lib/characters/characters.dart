import 'dart:convert';

import 'package:superhero/characters/i_characters.dart';
import 'package:superhero/models/heroes_response.dart';
import 'package:superhero/models/hr_byid.dart';
import 'package:superhero/models/main_response.dart';
import 'package:http/http.dart' as http;

class GetCharacters implements ICharcters{
  @override
  Future<HRById?> getById(String id) async{
    try{
      http.Response response= await http.get(Uri.parse("https://superheroapi.com/api/2056346418033559/$id"));
      if(response.statusCode==200){
        print("GOOD.");
        // print(response.body);
        print("__________________________");
        // print(HRById.fromJson(jsonDecode(response.body)).biography?.aliases);
        print("__________________________");
        return HRById.fromJson(jsonDecode(response.body));
      }else{
        print("BAD!");
        return null;
      }
    }catch(e){
      print(e);
    }
    return null;
  }

  @override
  Future<MainResponse?> getByName(String name) async{
    try{
      http.Response response = await http.get(Uri.parse("https://superheroapi.com/api/2056346418033559/search/$name"));
      if(response.statusCode==200){
        print("GOOD NAME.");
        return MainResponse.fromJson(jsonDecode(response.body));
      }else{
        print("BAD NAME!");
        return null;
      }
    }catch(e){
      print(e);
    }
  }

}