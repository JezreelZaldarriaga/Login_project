import 'package:flutter/material.dart';
import 'package:login_project/screens/login.dart';
import 'package:avatar_glow/avatar_glow.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _navigateToNextScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  //Template initialize (style, border)
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  OutlineInputBorder outlineBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      //Background Container
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/home-bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      //Glowing Circle Container
      Container(
        alignment: Alignment(0, -0.23),
        child: AvatarGlow(
          startDelay: Duration(milliseconds: 1000),
          glowColor: Colors.white,
          endRadius: 180.0,
          duration: Duration(milliseconds: 2000),
          repeat: true,
          showTwoGlows: true,
          repeatPauseDuration: Duration(milliseconds: 100),
          child: MaterialButton(
            onPressed: () {
              print("GO");
            },
            elevation: 0.0,
            shape: CircleBorder(),
          ),
        ),
      ),
      //Footer App bar Image Container
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons-tab.png"),
            alignment: Alignment(1, 1),
          ),
        ),
      ),
      //Play button Container
      Container(
        child: IconButton(
          icon: Image.asset('assets/play.png'),
          iconSize: 70,
          onPressed: () {},
        ),
        alignment: Alignment(0, 0.96),
      ),
      
      Container(
        //width: MediaQuery.of(context).size.width * 1,
        //height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/circle-1.png"),
            alignment: Alignment(0, 0),
          ),
        ),
      ),
      //10:00 timer display Container
      Container(
        width: MediaQuery.of(context).size.width * 1,
        alignment: Alignment(0, -0.12),
        child: Text(
          '10:00',
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            //fontWeight: FontWeight.bold,
            fontSize: 70,
          ),
        ),
      ),
      //Start now text container
      Container(
        width: MediaQuery.of(context).size.width * 1,
        alignment: Alignment(0, 0.6),
        child: Text(
          'START NOW!',
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontSize: 25,
          ),
        ),
      ),
      //Logout Container
      Container(
        child: MaterialButton(
          elevation: 5,

          padding: EdgeInsets.fromLTRB(20.0, 30.0, 40.0, 15.0),
          onPressed: () {
            _navigateToNextScreen(context);
          },

          child: Text(
            'log out',
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 16,
            ),
          ),
        ),
        alignment: Alignment(1, -1),
      ),
    ]));
  }
}
