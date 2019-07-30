import 'package:flutter/cupertino.dart';
import 'package:hack_mobility/model/coordinate.dart';
import 'package:hack_mobility/model/transport_mode.dart';
import 'package:scoped_model/scoped_model.dart';

class AppState extends Model {
  int _counter = 0;
  int get counter => _counter;

  double _originLatitude;

  double get originLatitude => _originLatitude;

  set originLatitude(double originLatitude) {
    _originLatitude = originLatitude;
  }
  double _originLongitude;

  double get originLongitude => _originLongitude;

  set originLongitude(double originLongitude) {
    _originLongitude = originLongitude;
  }

  double _destinyLatitude;

  double get destinyLatitude => _destinyLatitude;

  set destinyLatitude(double destinyLatitude) {
    _destinyLatitude = destinyLatitude;
  }
  double _destinyLongitude;

  double get destinyLongitude => _destinyLongitude;

  set destinyLongitude(double destinyLongitude) {
    _destinyLongitude = destinyLongitude;
  }

  void increment() {
    _counter++;
    notifyListeners();
  }

  List<TransportMode> _transportModes = List();
  List<TransportMode> get transportModes => _transportModes;


  orderByPrice() {
    _transportModes.sort((a, b) => a.price.compareTo(b.price));
    notifyListeners();
  }

  orderByDistance() {
    _transportModes.sort((a, b) => a.distance.compareTo(b.distance));
    notifyListeners();
  }

  orderByETA() {
    _transportModes.sort((a, b) => a.eta.compareTo(b.eta));
    notifyListeners();
  }

  orderByCarbonFootprint() {
    _transportModes
        .sort((a, b) => a.carbonFootprint.compareTo(b.carbonFootprint));
    notifyListeners();
  }

  prepareTransportList(Map<String, dynamic> data) {
    Map<String,dynamic> statistics = Map();
    statistics = data['data']['statistics'];

    Map<String,dynamic> summary = Map();
    summary = data['data']['summary'];

    Map<String,dynamic> origin = Map();
    origin = summary['geo0'];
    Map<String,dynamic> destiny = Map();
    destiny = summary['geo1'];

    Coordinate origem = Coordinate(latitude: origin['Latitude'], longitude: origin['Longitude']);
    Coordinate destino = Coordinate(latitude: destiny['Latitude'], longitude: destiny['Longitude']);

    _transportModes = List();
    _transportModes.add(TransportMode.fromJson(statistics['bike'], 'Bike', origem, destino));
    _transportModes.add(TransportMode.fromJson(statistics['bus'], 'Public transport', origem, destino));
    _transportModes.add(TransportMode.fromJson(statistics['car'], 'Car (alone)', origem, destino));
    _transportModes.add(TransportMode.fromJson(statistics['car-pool'], 'Carpool', origem, destino));
    _transportModes.add(TransportMode.fromJson(statistics['e-bike'], 'E-bike', origem, destino));
    _transportModes.add(TransportMode.fromJson(statistics['e-car'], 'E-car', origem, destino));

    orderByCarbonFootprint();
    notifyListeners();
  }

}
