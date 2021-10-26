import "package:flutter/material.dart";
import 'package:track_ui/track.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // var to store
  // onChanged callback

  final myController1 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tracking Order',
        theme: ThemeData(
          primarySwatch: Colors.red,
         /* scaffoldBackgroundColor:  Colors.red[],*/
        ),
        home: Scaffold(
            appBar: AppBar(
            title: const Text('TRACKING ORDER',
              style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
              elevation: 10.0,
              backgroundColor: const Color.fromRGBO(222, 29, 62, 0.8),
              ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: myController1,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Color(0xFF1A237E)),
                              borderRadius: BorderRadius.circular(10.0)),
                          hintText: 'Enter your Tracking Number',
                          prefixIcon: const Icon(
                            Icons.confirmation_num,
                            color: Colors.green,
                          ),
                          suffixStyle: const TextStyle(color: Colors.green)),
                      style: const TextStyle(fontSize: 16.0, color: Colors.black),
                      maxLines: 1,
                      onChanged: (value) {
                        //Do something with this value
                      },
                    )
                ),
                  const SizedBox(
                    height: 5,
                  ),
                  ButtonTheme(
                    minWidth: 150.0,
                    height: 50.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(color: Color(0xFF1A237E))),
                      onPressed: () async {
                        print(myController1.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Track(
                                      myController1.text
                                      )),
                        );
                      },
                      padding: const EdgeInsets.all(10.0),
                      color: const Color.fromRGBO(33, 64, 141, 1),
                      textColor: Colors.white,
                      child: const Text("TRACK", style: TextStyle(fontSize: 18)),
                      elevation: 8,
                    ),
                  ),

        ],
      ),
    ));
  }
}