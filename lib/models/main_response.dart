import 'dart:convert';

import 'package:superhero/models/heroes_response.dart';

class MainResponse{
  late String response;
  late String resultsFor;
  late List<HeroesResponse> results;  // late List<dynamic?>? results;

  MainResponse(
      this.response,
      this.resultsFor,
      this.results,
      );

  MainResponse.fromJson(Map<String, dynamic> json){
    response= json["response"];
    resultsFor= json["results-for"];
    results= List<HeroesResponse>.from(json["results"].map((model)=> HeroesResponse.fromJson(model)));
  }
}