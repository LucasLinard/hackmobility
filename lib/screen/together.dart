import 'package:flutter/material.dart';
import 'package:hack_mobility/components/my_flutter_app_icons.dart';
import 'package:hack_mobility/components/pie_legend.dart';

class Together extends StatefulWidget {
  @override
  _TogetherState createState() => _TogetherState();
}

class _TogetherState extends State<Together> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Your balance:'),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              leading: Icon(MyFlutterApp.leaf, color: Colors.green,),
              title: Text('EcoTokens', style: TextStyle(fontSize: 22), ),
              trailing: Text('5.3', style: TextStyle(fontSize: 22),),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "These are your CO2 emissions by transport mode:",
              style: TextStyle(fontSize: 22),
            ),
          ),
          Expanded(child: SimpleDatumLegend.withSampleData()),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'You could reduce your carbon footprint by 17% by car-pooling with a friend thrice a week',
              style: TextStyle(fontSize: 22),
            ),
          )
        ],
      ),
    );
  }
}
