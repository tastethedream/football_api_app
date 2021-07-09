import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';

class ClubScreen extends StatefulWidget {
  String teamName;
  ClubScreen(this.teamName);

  // in table screen this 'code' is hard coded need to make this the selected team from the table
  //final String code;

  //const ClubScreen({Key key, this.code}) : super(key: key);
  @override
  _ClubScreenState createState() => _ClubScreenState(teamName);
}

class _ClubScreenState extends State<ClubScreen> {
  List _team;
  String teamName;

  _ClubScreenState(this.teamName);

  getTable() async {
    http.Response response = await http.get(
        //'https://api.football-data.org/v2/competitions/{id}/matches',
        'https://api.football-data.org/v2/competitions/PL/standings',
        headers: {'X-Auth-Token': FlutterConfig.get('API_KEY')});
    String body = response.body;
    Map data = jsonDecode(body);
    List team = data['standings'][0]['table'];
    setState(() {
      _team = team;
    });
  }

  Widget buildTable() {
    List<Widget> teams = [];
    for (var team in _team) {
      teams.add(
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    team['position'].toString().length > 1
                        ? Text(team['position'].toString() + ' - ')
                        : Text(" " + team['position'].toString() + ' - '),
                    GestureDetector(
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(
                        //builder: (context) => DetailScreen(),

                        //));
                        print(team);
                      },
                      child: Row(
                        children: [
                          SvgPicture.network(
                            team['team']['crestUrl'],
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 5.0),
                          team['team']['name'].toString().length > 11
                              ? Text(team['team']['name']
                                      .toString()
                                      .substring(0, 11) +
                                  '...')
                              : Text(team['team']['name'].toString()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(team['playedGames'].toString()),
                    Text(team['won'].toString()),
                    Text(team['draw'].toString()),
                    Text(team['lost'].toString()),
                    Text(team['goalDifference'].toString()),
                    Text(team['points'].toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      children: teams,
    );
  }

  @override
  void initState() {
    super.initState();
    getTable();
  }

  @override
  Widget build(BuildContext context) {
    return _team == null
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFe70066),
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Team Details'),
              centerTitle: true,
              backgroundColor: Color(0xff33ccff),
              elevation: 50.0,
            ),
            body: Container(
              child: Text('You selected $teamName'),
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
            ));
  }
}
