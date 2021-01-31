import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_project/screens/home.dart';
import 'package:rive/rive.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;
  //rive artboard per riv file
  Artboard _riveArtboard, _riveArtboard1;
  //initializing rive animation controller to activate animation
  RiveAnimationController _controller;

  void _togglePlay() {
    setState(() => _controller.isActive = !_controller.isActive);
  }

  //===========
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var textVisible = false;

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    rootBundle.load('assets/catfin.riv').then(
      (data) async {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.

          artboard.addController(_controller = SimpleAnimation('wiggle-ears'));
          setState(() => _riveArtboard = artboard);
        }
      },
    );

    rootBundle.load('assets/half_moon.riv').then(
      (data) async {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard1 = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.

          artboard1.addController(_controller = SimpleAnimation('animatemoon'));
          setState(() => _riveArtboard1 = artboard1);
        }
      },
    );
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }
//initializing textstyle templates and outline border
  TextStyle style = TextStyle(
      fontFamily: 'Inter', fontSize: 20.0, fontWeight: FontWeight.bold);
  OutlineInputBorder outlineBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0));


  @override
  Widget build(BuildContext context) {
    //Email TF template initialize
    final emailField = TextField(
        controller: emailController,
        obscureText: false,
        style: style,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            fillColor: Color(0x77ffffff),
            filled: true,
            contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            hintText: "Email",
            border: outlineBorder));
    //password TF template initialize
    final passwordField = TextField(
        controller: passwordController,
        obscureText: true,
        style: style,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            fillColor: Color(0x77ffffff),
            filled: true,
            contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            hintText: "Password",
            border: outlineBorder));
    //login button template initialize
    final loginBtn = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xff479bb3),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (emailController.text == 'cictapps@wvsu.edu.ph' &&
              passwordController.text == '1234') {
            print("Signed in");
            _navigateToNextScreen(context);
          } else {
            print("Sorry");
            setState(() {
              textVisible = true;
            });
          }
        },
        child: Text("Sign in",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return new Scaffold(

        resizeToAvoidBottomInset: false,
        body: Stack(children: <Widget>[
          //Background Image Container
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.gif"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //RIVE File animation Container
          Container(
            margin: EdgeInsets.fromLTRB(170, 150, 100, 480),
            width: MediaQuery.of(context).size.width * 1,

            height: 150,
            //color: Colors.red,
            alignment: Alignment(-0.3, 0),
            child: _riveArtboard1 == null
                ? const SizedBox()
                : Rive(artboard: _riveArtboard1),
          ),
          //RIVE File animation Container
          Container(
            margin: EdgeInsets.fromLTRB(100, 300, 100, 300),
            child: _riveArtboard == null
                ? const SizedBox()
                : Rive(artboard: _riveArtboard),
          ),
          //Gradient image Cover container
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/gradient.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //login fields, buttons, display texts 
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Center(
                      child: new Stack(
                    children: <Widget>[
                      new Column(children: <Widget>[
                        SizedBox(height: 45.0),
                        Visibility(
                            visible: textVisible,
                            child: Text(
                              'Invalid Input',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            )),
                        FractionallySizedBox(
                          widthFactor: 0.8,
                          child: emailField,
                        ),
                        SizedBox(height: 25.0),
                        FractionallySizedBox(
                          widthFactor: 0.8,
                          child: passwordField,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.5,
                          child: loginBtn,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ])
                    ],
                  )),
                )
              ])
        ]));
  }
}
