import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';

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
  String website;
  String address;
  String crestURL;
  String stadium;
  String email;

  getTeamDetails() async {
    http.Response response = await http.get(
        'https://api.football-data.org/v2/teams/${widget.id}',
        headers: {'X-Auth-Token': FlutterConfig.get('API_KEY')});
    String body = response.body;
    Map data = jsonDecode(body);
    print('this is Json ${response.body}');
    website = data['website'];
    address = data['address'];
    crestURL = data['crestUrl'];
    stadium = data['venue'];
    email = data['email'];
    print('venue: $stadium');
    setState(() {
       });
  }

  @override
  void initState() {
    super.initState();
    getTeamDetails();
  }

  @override
  Widget build(BuildContext context) {

    if ( website == null) {
      return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xFFe70066),
          ),
        ),
      ),
    );
    } else {
      return Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('$teamName',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
                SvgPicture.network(
                  crestURL,
                  height: 120,
                  width: 120,
                ),

                Text('$stadium',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                Text('$address',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                Text('$website',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                Text('$email',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                SizedBox(height: 10.0),
              ],
            )
        ),
      );
    }
  }
}