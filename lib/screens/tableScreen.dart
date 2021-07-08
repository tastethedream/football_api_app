import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:sports_api/screens/clubScreen.dart';
import 'package:flutter_config/flutter_config.dart';


class TableScreen extends StatefulWidget {
  final String code;

  const TableScreen({Key key, this.code}) : super(key: key);
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List _table;

  getTable() async {
    http.Response response = await http.get(
        'https://api.football-data.org/v2/competitions/${widget.code}/standings',
        headers: {'X-Auth-Token': FlutterConfig.get('API_KEY')});
    String body = response.body;
    Map data = jsonDecode(body);
    List table = data['standings'][0]['table'];
    setState(() {
      _table = table;
    });


  }



  Widget buildTable() {
    List<Widget> teams = [];
    for (var team in _table) {
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
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ClubScreen(),

                        ));

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
    return _table == null
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
              title: Text(
                  'League Table'),
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
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Pos',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Club',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'PL',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        Text(
                          'W',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        Text(
                          'D',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        Text(
                          'L',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        Text(
                          'GD',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        Text(
                          'PTS',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildTable(),
          ],
        ),
      ),
    );
  }
}
