import 'package:flutter/cupertino.dart';
import 'package:hack_mobility/model/transport_mode.dart';
import 'package:scoped_model/scoped_model.dart';

class AppState extends Model {
  int _counter = 0;
  int get counter => _counter;

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
    data = data['data']['statistics'];
    print('**********************');
    print(data);
    _transportModes = List();
    _transportModes.add(TransportMode.fromJson(data['bike'], 'Bike'));
    _transportModes.add(TransportMode.fromJson(data['bus'], 'Public transport'));
    _transportModes.add(TransportMode.fromJson(data['car'], 'Car (alone)'));
    _transportModes.add(TransportMode.fromJson(data['car-pool'], 'Carpool'));
    _transportModes.add(TransportMode.fromJson(data['e-bike'], 'E-bike'));
    _transportModes.add(TransportMode.fromJson(data['e-car'], 'E-car'));
    orderByCarbonFootprint();
    notifyListeners();
  }

}
