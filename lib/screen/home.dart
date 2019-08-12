import 'dart:convert';
import 'dart:math';
import 'package:hack_mobility/model/coordinate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:hack_mobility/Util/Network.dart';
import 'package:hack_mobility/components/my_flutter_app_icons.dart';
import 'package:hack_mobility/model/app_state.dart';
import 'package:hack_mobility/model/transport_mode.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController originController;
  TextEditingController destinyController;
  bool imageFetched = false;
  String imageUrl;
  @override
  void initState() {
    super.initState();
    originController = TextEditingController.fromValue(
        TextEditingValue(text: "440 N Wolfe R, Sunnyvale"));
    destinyController = TextEditingController.fromValue(
        TextEditingValue(text: "44 Tehama St, San Francisco, CA 94105"));
    columns = [
      DataColumn(
        label: Text('Mode'),
      ),
      DataColumn(
        onSort: (index, value) {
          ScopedModel.of<AppState>(context, rebuildOnChange: true)
              .orderByDistance();
        },
        numeric: true,
        label: Text('miles'),
      ),
      DataColumn(
          onSort: (index, value) {
            ScopedModel.of<AppState>(context, rebuildOnChange: true)
                .orderByDistance();
          },
          numeric: true,
          label: Text('\$')),
      DataColumn(numeric: true, label: Text('minutes')),
      DataColumn(
        numeric: true,
        label: Text('gCO2'),
      ),
    ];
    rows = [];
  }

  List<DataColumn> columns;
  List<DataRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: originController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.home),
                    hintText: 'Where are you now?',
                    labelText: 'Origin',
                  ),
                  onSaved: (String value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (String value) {
                    return value.contains('@')
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
              ),
            )
          ]),
          Row(children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: destinyController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.map),
                    hintText: 'Where do you want to go?',
                    labelText: 'Destiny',
                  ),
                  onSaved: (String value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (String value) {
                    return value.contains('@')
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
              ),
            )
          ]),
          ButtonTheme(
            child: ScopedModelDescendant<AppState>(
              builder: (context, _, model) => RaisedButton(
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  NetworkUtil.postAddressData(
                          originController.text, destinyController.text)
                      .then((response) {
                    if (response.statusCode == 200) {
                      Map<String, dynamic> data = jsonDecode(response.body);
                      model.prepareTransportList(data);
                      setState(() {
                        imageFetched = true;
                        print(data['data']['routes']['car']);
                        imageUrl = data['data']['routes']['car'];
                        rows = model.transportModes.map((tm) {
                          return createDataRow(tm);
                        }).toList();
                      });
                    } else {
                      print('bad response');
                    }
                  });
                },
              ),
            ),
          ),
          Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: imageFetched ? Image.network(imageUrl) : SizedBox(),
              )),
          Expanded(
            flex: 4,
            child: ScopedModelDescendant<AppState>(
              builder: (BuildContext context, Widget child, AppState model) {
                return ListView(
                  children: <Widget>[
                    DataTable(
                      columnSpacing: 5,
                      columns: columns,
                      rows: rows,
                      sortColumnIndex: 4,
                      sortAscending: true,
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  DataRow createDataRow(TransportMode tm) {

    DataCell name = DataCell(GestureDetector(
        onTap: () {
          _launchURL(buildUri(originController.text, destinyController.text, tm.origem, tm.destino));
        },
        child: ListTile(title: Text(tm.name), leading: tm.icon)));
    DataCell distance = DataCell(Text(tm.distance.toString()));
    DataCell price = DataCell(Text(tm.price.toString()));
    DataCell eta = DataCell(Text(tm.eta.toString()));
    DataCell footprint = DataCell(Text(tm.carbonFootprint.toString()));
    return DataRow(cells: [name, distance, price, eta, footprint]);
  }
  String buildUri(String pickup, String dropoff, Coordinate origem, Coordinate destino) {
    String authority = "m.uber.com";
    String unencodedPath = "/ul";
    Map<String,String> parameters = Map();

    parameters['client_id'] = 'Myc2WmfGR25p4eIAsAA1GtW_C1B4qBqS';
    parameters['action'] = 'setPickup';

    parameters['pickup[formatted_address]'] = pickup;
    parameters['dropoff[formatted_address]'] = dropoff;

    parameters['pickup[latitude]'] = origem.latitude.toString();
    parameters['pickup[longitude]'] = origem.longitude.toString();

    parameters['dropoff[latitude]'] = destino.latitude.toString();
    parameters['dropoff[longitude]'] = destino.longitude.toString();

    return Uri.https(authority, unencodedPath, parameters).toString();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      print(url);
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
