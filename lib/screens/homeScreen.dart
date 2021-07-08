import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sports_api/widgets/leagueContainer.dart';
import 'tableScreen.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: SafeArea(
        child: Container(

          
          decoration: BoxDecoration(
              image: DecorationImage(
              //image: NetworkImage('https://images.unsplash.com/photo-1610017128786-4a25f0f7756c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80'),
                image: NetworkImage('https://images.unsplash.com/photo-1511426463457-0571e247d816?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80'),
                fit: BoxFit.cover,
    ),
             // gradient: LinearGradient(
             // colors: [
              //  const Color(0xffe84860),
               // const Color(0xffe70066),
             // ],
             // begin: const FractionalOffset(0.0, 0.0),
            //  end: const FractionalOffset(0.0, 1.0),
             // stops: [0.0, 1.0],
            //  tileMode: TileMode.clamp,
            ),


          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
                SizedBox(height: 20.0),

                Text(
                  'Competitions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,

                  ),
                ),


                SizedBox(height: 30.0),
                GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                  crossAxisSpacing: 45,
                  mainAxisSpacing: 45,
                  children: [
                    GestureDetector(
                      child: LeagueContainer(image:"assets/pl.png"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => TableScreen(code: 'PL'),
                        ));
                      },
                    ),
                    GestureDetector(
                      child: LeagueContainer(image:"assets/laliga.png"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => TableScreen(code: 'PD'),
                        ));
                      },
                    ),
                    GestureDetector(
                      child: LeagueContainer(image:"assets/bundesliga.png"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => TableScreen(code: 'BL1'),
                        ));
                      },
                    ),
                    GestureDetector(
                      child: LeagueContainer(image:"assets/seria.png"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => TableScreen(code: 'SA'),
                        ));
                      },
                    ),
                    GestureDetector(
                      child: LeagueContainer(image:"assets/ligue1.png"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => TableScreen(code: 'FL1'),
                        ));
                      },
                    ),  GestureDetector(
                      child: LeagueContainer(image:"assets/nos.png"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => TableScreen(code: 'PPL'),
                        ));
                      },
                    ),

                  ],



                )
              ],
            ),
    ),
          )));


  }
}
