import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class TeamScreen extends StatefulWidget {
  final String teamName;
  final int id;
  TeamScreen(this.teamName, this.id);

  @override
  _TeamScreenState createState() => _TeamScreenState(teamName, id);
}

class _TeamScreenState extends State<TeamScreen> {
  _TeamScreenState(this.teamName, this.id);

  String teamName;
  int id;

/*
  getTeam() async {
    http.Response response = await http.get(
       'https://api.football-data.org/v2/competitions/${widget.code}/standings',

      headers: {'X-Auth-Token': 'api key here'});
    String body = response.body;
    Map data = jsonDecode(body);
    List table = data['standings'][0]['table'];
    setState(() {
      //_team = team;
    });
    //debugPrint('Table: $_table');
    //print(team);
    //print(response);
  }

 */

  @override
  void initState() {
    super.initState();
    // getTeam();
  }

/*
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
          child: Text('You selected $teamName team ID is $id'),

        ));
  }

 */
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
              Text('You selected $teamName'),
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