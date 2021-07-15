import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';

class TeamScreen extends StatefulWidget {
  final String teamName;
  final int id;
  TeamScreen(this.teamName, this.id);

  @override
  _TeamScreenState createState() => _TeamScreenState(teamName, id);
}

class TeamDetails {
  TeamDetails({@required this.website});
  final String website;
}

class _TeamScreenState extends State<TeamScreen> {

  _TeamScreenState(this.teamName, this.id);

  List _teamDetails;
  String teamName;
  int id;






  getTeamDetails() async {
    http.Response response = await http.get(
       'https://api.football-data.org/v2/teams/${widget.id}',
        headers: {'X-Auth-Token': FlutterConfig.get('API_KEY')});
    String body = response.body;
    Map data = jsonDecode(body);
    print(response.body);
    // not sure what goes in teamDetails list ????
    //List teamDetails = data['teams'];
   // setState(() {
    // _teamDetails = teamDetails;
   //});

  }

  @override
  void initState() {
    super.initState();
    getTeamDetails();
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
              Text('You selected $teamName'),
              Text(' Website: '),
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