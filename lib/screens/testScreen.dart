import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';

class TestScreen extends StatefulWidget {
  final String teamName;
  final int id;
  TestScreen(this.teamName, this.id, );

  @override
  _TestScreenState createState() => _TestScreenState(teamName, id,);
}


class Details {
  Details({@required this.id, @required this.name, @required this.website});
  final int id;
  final String name;
  final String website;

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
    id: json['id'],
    name: json['name'],
    website: json['website'],
    );
  }
}

class _TestScreenState extends State<TestScreen> {

  _TestScreenState(this.teamName, this.id, );

  //List _teamDetails;
  String teamName;
  int id;



  Future<Details> getTeamDetails() async {
    final response = await http.get('https://api.football-data.org/v2/teams/57',
        headers: {'X-Auth-Token': FlutterConfig.get('API_KEY')});
    String body = response.body;
    Map data = jsonDecode(body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Details.fromJson(jsonDecode(response.body));
          } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }


  @override
  void initState() {
    super.initState();
    getTeamDetails();

    //futureDetails = getTeamDetails();
  }


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Team Details'),
          centerTitle: true,
          backgroundColor: Color(0xff33ccff),
          elevation: 50.0,
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff33ccff),
                    const Color(0xff007399),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You have selected $teamName'),
                SizedBox(height: 10.0),

                Text('Team ID is $id'),
                //SizedBox(height: 10.0),
                // SvgPicture.network(
                // team['team']['crestUrl'],
                // height: 30,
                // width: 30,
                //),

              ],
            )
        ),
      );
  }
}

