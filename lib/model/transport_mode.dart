import 'dart:convert';

import 'package:flutter/material.dart';

class TransportMode {
  String name;
  double price;
  double distance;
  int eta;
  int carbonFootprint;
  Icon icon;


  TransportMode({this.name, this.price, this.distance, this.eta,
      this.carbonFootprint, this.icon,});

  factory TransportMode.fromJson(Map<String, dynamic> json, String nome) {
    return TransportMode(
      name: nome,
      price: json['price'],
      distance: json['distance'],
      eta: json['eta'],
      carbonFootprint: json['footprint'],
      icon: Icon(Icons.ac_unit)
    );
  }
}
