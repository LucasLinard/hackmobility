import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hack_mobility/components/my_flutter_app_icons.dart';
import 'package:hack_mobility/model/coordinate.dart';

Map<String, Widget> icons = {
  'Bike': Icon(MyFlutterApp.bicycle),
  'Public transport': Icon(MyFlutterApp.directions_bus),
  'Car (alone)': Image.asset('assets/uber.png',width: 24,height: 24,),
  'Carpool': Image.asset('assets/uber.png',width: 24,height: 24,),
  'E-bike': Image.asset('assets/jump.png',width: 24,height: 24,),
  'E-car': Icon(MyFlutterApp.battery_charging_full),
};

class TransportMode {
  String name;
  double price;
  double distance;
  int eta;
  int carbonFootprint;
  Widget icon;
  Coordinate origem;
  Coordinate destino;

  TransportMode({
    this.name,
    this.price,
    this.distance,
    this.eta,
    this.carbonFootprint,
    this.icon,
    this.origem,
    this.destino
  });

  factory TransportMode.fromJson(Map<String, dynamic> json, String nome, Coordinate origem, Coordinate destino) {
    return TransportMode(
        name: nome,
        price: json['price'],
        distance: json['distance'],
        eta: json['eta'],
        carbonFootprint: json['footprint'],
        icon:icons[nome],
        origem: origem,
        destino: destino);
  }
}
