import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hack_mobility/Util/Network.dart';
import 'package:hack_mobility/components/google_map.dart';
import 'package:hack_mobility/model/app_state.dart';
import 'package:hack_mobility/model/transport_mode.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController originController = TextEditingController();
  TextEditingController destinyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    columns = [
      DataColumn(
        label: Text('Modal'),
      ),
      DataColumn(
        onSort: (index, value) {
          ScopedModel.of<AppState>(context, rebuildOnChange: true)
              .orderByDistance();
        },
        numeric: true,
        label: Text('Distance'),
      ),
      DataColumn(
          onSort: (index, value) {
            ScopedModel.of<AppState>(context, rebuildOnChange: true)
                .orderByDistance();
          },
          numeric: true,
          label: Text('Price')),
      DataColumn(numeric: true, label: Text('ETA')),
      DataColumn(
        numeric: true,
        label: Text('Footprint'),
      ),
    ];
    rows = [];
  }

  List<DataColumn> columns;
  List<DataRow> rows;

  @override
  Widget build(BuildContext context) {
    NetworkUtil.postAddressData(
        "440 N Wolfe R, Sunnyvale", "103 Brahms Way, Sunnyvale");
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
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
                child: Text('Search'),
                onPressed: () {
                  NetworkUtil.postAddressData("440 N Wolfe R, Sunnyvale",
                          "103 Brahms Way, Sunnyvale")
                      .then((response) {
                    if (response.statusCode == 200) {
                      Map<String, dynamic> data = jsonDecode(response.body);
                      model.prepareTransportList(data);
                      setState(() {
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
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MapSmall(),
              )),
          Expanded(
            flex: 6,
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
    print('createDataRow');
    DataCell name = DataCell(Text(tm.name));
    DataCell distance = DataCell(Text(tm.distance.toString()));
    DataCell price = DataCell(Text(tm.price.toString()));
    DataCell eta = DataCell(Text(tm.eta.toString()));
    DataCell footprint = DataCell(Text(tm.carbonFootprint.toString()));
    return DataRow(cells: [name, distance, price, eta, footprint]);
  }
}
