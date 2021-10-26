import 'dart:io';
import 'dart:ui';

import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';




Future<StatusModel> fetchStatusModel(myController1) async {
  final response = await http
      .get(Uri.parse("https://portal.nepalcanmove.com/api/v1/order/track?trackingid=" + myController1),
  );

  if (response.statusCode == 200 || response.statusCode == 401)  {
    print(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonResponse = json.decode(response.body);
    return StatusModel.fromJson(jsonResponse);

  } else {
    print(response.body);
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('detail: Not found.');
  }
}

class StatusModel {

  final dynamic details;
  final List status;


  StatusModel({
    required this.details,
    required this.status,


  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      details: json['details'],
      status: json['status'],

    );
  }
}

class Track extends StatefulWidget {
  final String myController1;
  const Track(this.myController1);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Track> {
  late Future<StatusModel> futureStatusModel;
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();


  @override
  void initState() {
    super.initState();
    futureStatusModel = fetchStatusModel(widget.myController1);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tracking',
        theme: FlexColorScheme.light(
          colors: FlexColor.schemes[FlexScheme.mandyRed]!.light,
        ).toTheme,
        themeMode: ThemeMode.system,

        home: Scaffold(
            appBar: AppBar(
              title: const Text('TRACKING ORDER',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              elevation: 10.0,
              backgroundColor: const Color.fromRGBO(222, 29, 62, 0.8),
            ),
            body: Column(children: <Widget>[


              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder<StatusModel>(
                  future: futureStatusModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      dynamic details = snapshot.data!.details;
                      List<dynamic> status = snapshot.data!.status;
                      Iterable<dynamic> reverse = status.reversed;
                      return ListView(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                              height: 20.0
                          ),

                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text("Tracking ID - ",
                                style: GoogleFonts.lato(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                details['trackid'] != null  ? details['trackid'] : '',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: const Color.fromRGBO(33, 64, 141, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),


                          const SizedBox(
                              height: 40.0
                          ),

                          const StepProgressIndicator(
                            totalSteps: 12,
                            currentStep: 4,
                            padding: 6.0,
                            size: 12,
                            progressDirection: TextDirection.rtl,
                            selectedColor: Colors.green,
                            unselectedColor: Colors.black12,
                            selectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.yellowAccent, Colors.deepOrange],
                            ),
                            unselectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.black, Colors.blue],
                            ),
                          ),

                          const SizedBox(
                              height: 60.0
                          ),

                          ExpansionTileCard(
                            baseColor: Colors.blue[400],
                            expandedColor: Colors.green[50],
                            key: cardA,
                            leading: CircleAvatar(
                              child: Image.asset("assets/images/info1.png"), backgroundColor: Colors.white,),
                            title: const Text("General Information", style: TextStyle(color: Colors.black),),
                            subtitle: const Text("Sender/Receiver's General Information", style: TextStyle(color: Colors.black),),
                            children: <Widget>[
                              const Divider(
                                thickness: 1.0,
                                height: 1.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 20.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[

                                      Row(
                                        children: [
                                          Image.asset("assets/images/sender.png", width: 35,),

                                          const SizedBox(width: 8),

                                          Text(
                                              'Sender',
                                              style: GoogleFonts.lato(
                                                fontSize: 19,
                                                color: const Color.fromRGBO(33, 64, 141, 1),
                                                fontWeight: FontWeight.bold,

                                              )),],
                                      ),


                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [

                                          Text(
                                            details['vendor'] != null  ? details['vendor'] : '',
                                            style: GoogleFonts.lato(
                                              fontSize: 17,
                                              color: Colors.black,
                                              /*fontWeight: FontWeight.bold,*/
                                            ),
                                          ),

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [

                                          Text(
                                            details['vendor_phone'] != null  ? details['vendor_phone'] : '',
                                            style: GoogleFonts.lato(
                                              fontSize: 17,
                                              color: Colors.black,
                                              /*fontWeight: FontWeight.bold,*/
                                            ),
                                          ),

                                        ],
                                      ),
                                      const SizedBox(height: 10),

                                      const Divider(
                                        color: Colors.black,
                                        thickness: 1.0,
                                        height: 1.0,
                                      ),

                                      const SizedBox(height: 10),


                                      Row(
                                        children: [
                                          Image.asset("assets/images/receiver.png", width: 35,),

                                          const SizedBox(width: 8),


                                          Text(
                                              'Receiver',
                                              style: GoogleFonts.lato(
                                                fontSize: 17,
                                                color: const Color.fromRGBO(33, 64, 141, 1),
                                                fontWeight: FontWeight.bold,

                                              )), ],
                                      ),




                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [

                                          Text(
                                            details['receiver'] != null  ? details['receiver'] : '',
                                            style: GoogleFonts.lato(
                                              fontSize: 17,
                                              color: Colors.black,
                                              /*fontWeight: FontWeight.bold,*/
                                            ),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [

                                          Text(
                                            details['receiver_phone'] != null  ? details['receiver_phone'] : '',
                                            style: GoogleFonts.lato(
                                              fontSize: 17,
                                              color: Colors.black,
                                              /*fontWeight: FontWeight.bold,*/
                                            ),
                                          ),
                                        ],
                                      ),


                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [

                                          Text(
                                            details['destination'] != null  ? details['destination'] : '',
                                            style: GoogleFonts.lato(
                                              fontSize: 17,
                                              color: Colors.black,
                                              /*fontWeight: FontWeight.bold,*/
                                            ),
                                          ),
                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              )],
                          ),


                          const Padding(
                            padding: EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                          ),
                          ExpansionTileCard(
                            baseColor: Colors.blue[300],
                            expandedColor: Colors.green[50],
                            key: cardC,
                            leading: CircleAvatar(
                              child: Image.asset("assets/images/order.png"), backgroundColor: Colors.white,),
                            title: const Text("Order Information", style: TextStyle(color: Colors.black),),
                            subtitle: const Text("Package Information", style: TextStyle(color: Colors.black),),
                            children: <Widget>[
                              const Divider(
                                thickness: 1.0,
                                height: 1.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 20.0,
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text("Weight -> ",
                                              style: GoogleFonts.lato(
                                                fontSize: 19,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              details['weight'] != null  ? details['weight'] : '' + "Unit/kg",
                                              style: GoogleFonts.lato(
                                                fontSize: 19,
                                                color: Colors.black,
                                                /*fontWeight: FontWeight.bold,*/
                                              ),
                                            ),
                                            const SizedBox(width: 3.0),

                                            Text("Unit/Kg ",
                                              style: GoogleFonts.lato(
                                                fontSize: 19,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),


                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text("COD -> ",
                                              style: GoogleFonts.lato(
                                                fontSize: 19,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              details['cod_charge'] != null  ? details['cod_charge'] : '',
                                              style: GoogleFonts.lato(
                                                fontSize: 19,
                                                color: Colors.black,
                                                /* fontWeight: FontWeight.bold,*/
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              )],
                          ),

                          const Padding(
                            padding: EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                          ),
                          ExpansionTileCard(
                            baseColor: Colors.blue[200],
                            expandedColor: Colors.green[50],
                            key: cardB,
                            leading: CircleAvatar(
                              child: Image.asset("assets/images/del.png"), backgroundColor: Colors.white,),
                            title: const Text("Status", style: TextStyle(color: Colors.black),),
                            subtitle: const Text("Delivery Status", style: TextStyle(color: Colors.black),),
                            children:  <Widget>[
                              const Divider(
                                thickness: 1.0,
                                height: 1.0,
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 20.0,
                                    ),

                                    child: Column(
                                      children: reverse
                                          .map(
                                            (stat) => Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[

                                              Align(
                                                alignment:
                                                Alignment.centerLeft,
                                                child: Text(
                                                  "◘ " + stat,
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.lato(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              )

                                            ]),
                                      )

                                          .toList(),



                                    ),

                                  )
                              )],

                          ),

                          const Padding(
                            padding: EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                          ),

                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 150),
                        child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.red,
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                            )));
                  },
                ),
              )
            ])));
  }
}

