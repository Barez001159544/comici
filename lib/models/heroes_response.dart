import 'dart:convert';
import 'dart:ui';

import 'package:superhero/models/powerstats.dart';
import 'package:superhero/models/work.dart';
import 'package:superhero/models/image.dart';

import 'appearance.dart';
import 'biography.dart';
import 'connections.dart';

class HeroesResponse{
  late String? id;
  late String? name;
  late Powerstats? powerstats;
  late Biography? biography;
  late Appearance? appearance;
  late Work? work;
  late Connections? connections;
  late Imagee? imagee;

  HeroesResponse(
      this.id,
      this.name,
      this.powerstats,
      this.biography,
      this.appearance,
      this.work,
      this.connections,
      this.imagee,
      );

  HeroesResponse.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    powerstats = Powerstats.fromJson(json["powerstats"]);
    biography = Biography.fromJson(json['biography']);
    appearance = Appearance.fromJson(json['appearance']);
    work = Work.fromJson(json['work']);
    connections = Connections.fromJson(json['connections']);
    imagee = Imagee.fromJson(json['image']);
  }

}