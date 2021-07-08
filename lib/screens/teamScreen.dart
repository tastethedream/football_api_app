import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class TeamScreen extends StatefulWidget {
  final String code;
  const TeamScreen({Key key, this.code}) : super(key: key);

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {

  List _table;

  getTeam() async {
    http.Response response = await http.get(
        'https://api.football-data.org/v2/competitions/${widget.code}/standings',
        headers: {'X-Auth-Token': 'api key here'});
    String body = response.body;
    Map data = jsonDecode(body);
    List table = data['standings'][0]['table'];
    setState(() {
      _table = table;
    });
    //debugPrint('Table: $_table');
    //print(team);
    //print(response);
  }




  @override
  void initState() {
    super.initState();
    getTeam();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
        ],
    ),

      ),

    );

  }
}
