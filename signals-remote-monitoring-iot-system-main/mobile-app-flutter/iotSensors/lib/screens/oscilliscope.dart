import 'dart:async';

/// Demo of using the oscilloscope package
///
/// In this demo 2 displays are generated showing the outputs for Sine & Cosine
/// The scope displays will show the data sets  which will fill the yAxis and then the screen display will 'scroll'
import 'package:flutter/material.dart';
import 'package:iotsensors/models/readings_model.dart';
import 'package:oscilloscope/oscilloscope.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


// MY FAKE DATA

class oscilloscope extends StatefulWidget {
  const oscilloscope({Key? key}) : super(key: key);

  @override
  _oscilloscopeState createState() => _oscilloscopeState();
}

class _oscilloscopeState extends State<oscilloscope> {
  // bool _isFirst = true;
  // late Future<List<sensorReading>> _future;

  List<double> tempVal = [];
  List<double> humidityVal = [];
  // double radians = 0.0;
  Timer? _timer;

  /// method to generate a Test  Wave Pattern Sets
  /// this gives us a value between +1  & -1 for sine & cosine
   _generateTrace(Timer t) async {
    //  //
    //  // setState(() {
    //  //   tempVal.add(tempVal.last );
    //  //   humidityVal.add(humidityVal.last );
    //  // });
    //
    //
    // // if (_isFirst){
    // //  get request with all trace data
    // String url = "https://mighty-headland-68010.herokuapp.com/getsensors";
    // final response = await http.get(Uri.parse(url));
    // var responseData = json.decode(response.body);
    //
    // // List<sensorReading> readings = [];
    //
    //
    // // for (var reading in responseData) {
    // //   sensorReading item = sensorReading(
    // //       sensorId: reading["sensorId"],
    // //       value: reading["value"],
    // //       InDtTm: reading["InDtTm"]);
    // //     readings.add(item);
    // // }
    //   // _isFirst = false;
    // // }
    //
    // // generate our  values
    // var tempFake = responseData["temp_value"];
    // var humidityFake = responseData["hum_value"];

     _generateTraceazoz();
    // Add to the growing dataset
    setState(() {
      tempVal.add(tempVal.last);
      humidityVal.add(humidityVal.last);
    });

    // if no new data fetched display same last value
    //
    // if (radians >= 2) {
    //   radians = 0.0;
    // }
  }

  _generateTraceazoz() async{

    String url = "https://mighty-headland-68010.herokuapp.com/getsensors";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);

    sensorReading item = sensorReading(
        temp_value: responseData["temp_value"],
        hum_value: responseData["hum_value"],
        InDtTm: responseData["InDtTm"]);


    // var tempFake = item.temp_value;
    // var humidityFake = item["hum_value"];

    // Add to the growing dataset
    // setState(() {
    tempVal.add(responseData["temp_value"]);
    humidityVal.add(responseData["hum_value"]);
    // });

    // return item;

  }


  @override
  initState() {
    super.initState();
    // create our timer to generate test values
    _timer = Timer.periodic(const Duration(milliseconds: 1000), _generateTrace);
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create A Scope Display for Sine
    Oscilloscope scopeOne = Oscilloscope(
      showYAxis: true,
      yAxisColor: Colors.orange,
      margin: const EdgeInsets.all(20.0),
      strokeWidth: 1.0,
      backgroundColor: Colors.black,
      traceColor: Colors.green,
      yAxisMax: 50,
      yAxisMin: 10,
      dataSet: tempVal,
    );


    // Create A Scope Display for Cosine
    Oscilloscope scopeTwo = Oscilloscope(
      showYAxis: true,
      margin: const EdgeInsets.all(20.0),
      strokeWidth: 3.0,
      backgroundColor: Colors.black,
      traceColor: Colors.yellow,
      yAxisMax: 50,
      yAxisMin: 10,
      dataSet: humidityVal,
    );

    // Generate the Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text("oscilation demo"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 1, child: scopeOne),
          Expanded(flex: 1, child: scopeTwo,

          ),
        ],
      ),
    );
  }

}




