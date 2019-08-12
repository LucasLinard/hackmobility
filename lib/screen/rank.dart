import 'package:flutter/material.dart';
import 'package:hack_mobility/components/donut.dart';

class Rank extends StatefulWidget {
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Icon(
            Icons.account_circle,
            color: Colors.green,
            size: 256,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Rank:', style: TextStyle(
                  fontSize: 36, color: Colors.black54
                ),),
                Text(' 2.222.754',style: TextStyle(
                    fontSize: 36, color: Colors.green
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Footprint reduced:',style: TextStyle(
                    fontSize: 24, color: Colors.black54
                )),
                Text('-456 gCO2',style: TextStyle(
                    fontSize: 24, color: Colors.green
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Participants: ', style: TextStyle(
                    fontSize: 24, color: Colors.black54
                ),),
                Text('3.000.000', style: TextStyle(
                    fontSize: 24, color: Colors.green
                ),),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Countries / areas:'),
          ),
          Divider(),
          ListTile(
            isThreeLine: true,
            title: Text('San Francisco'),
            trailing: Text('# 20.123'),
            subtitle: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.green[800],
                        Colors.green[700],
                        Colors.green[600],
                        Colors.green[100],
                      ]
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Monthly CO2 reduction: ', style:
                  TextStyle(
                      color: Colors.white
                  ),),
                  Text('-123 gCo2 '),
                ],
              ),
            ),
            dense: true,
          ),

          Divider(),
          ListTile(
            isThreeLine: true,
            title: Text('Californa'),
            trailing: Text('# 212.522'),
            subtitle: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.green[700],
                        Colors.green[500],
                        Colors.green[300],
                        Colors.green[100],
                      ]
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Monthly CO2 reduction: ', style:
                  TextStyle(
                      color: Colors.white
                  ),),
                  Text('-123 gCo2 '),
                ],
              ),
            ),
              dense: true
          ),
          Divider(),
          ListTile(
            isThreeLine: true,
            title: Text('United States'),
            trailing: Text('# 2.222.754'),
            subtitle: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.green[400],
                        Colors.green[300],
                        Colors.green[200],
                        Colors.green[100],
                      ]
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Monthly CO2 reduction: ', style:
                  TextStyle(
                      color: Colors.white
                  ),),
                  Text('-123 gCo2 '),
                ],
              ),
            ),
              dense: true
          ),

        ],
      ),
    );
  }
}
