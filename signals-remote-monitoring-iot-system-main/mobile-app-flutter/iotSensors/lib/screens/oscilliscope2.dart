import 'dart:async';
import 'dart:math';

/// Demo of using the oscilloscope package
///
/// In this demo 2 displays are generated showing the outputs for Sine & Cosine
/// The scope displays will show the data sets  which will fill the yAxis and then the screen display will 'scroll'
import 'package:flutter/material.dart';
import 'package:oscilloscope/oscilloscope.dart';



class oscilloscope2 extends StatefulWidget {
  const oscilloscope2({Key? key}) : super(key: key);

  @override
  _oscilloscope2State createState() => _oscilloscope2State();
}

class _oscilloscope2State extends State<oscilloscope2> {

  List<double> traceSine = [];
  List<double> traceCosine = [];
  double radians = 0.0;
  Timer? _timer;

  /// method to generate a Test  Wave Pattern Sets
  /// this gives us a value between +1  & -1 for sine & cosine
  _generateTrace(Timer t) {
    // generate our  values
    var sv = sin((radians * pi));
    var cv = cos((radians * pi));

    // Add to the growing dataset
    setState(() {
      traceSine.add(sv);
      traceCosine.add(cv);
    });

    // adjust to recyle the radian value ( as 0 = 2Pi RADS)
    radians += 0.05;
    if (radians >= 2) {
      radians = 0.0;
    }
  }

  @override
  initState() {
    super.initState();
    // create our timer to generate test values
    _timer = Timer.periodic(Duration(milliseconds: 60), _generateTrace);
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
      margin: EdgeInsets.all(20.0),
      strokeWidth: 1.0,
      backgroundColor: Colors.black,
      traceColor: Colors.green,
      yAxisMax: 1.0,
      yAxisMin: -1.0,
      dataSet: traceSine,
    );

    // Create A Scope Display for Cosine
    Oscilloscope scopeTwo = Oscilloscope(
      showYAxis: true,
      margin: EdgeInsets.all(20.0),
      strokeWidth: 3.0,
      backgroundColor: Colors.black,
      traceColor: Colors.yellow,
      yAxisMax: 10,
      yAxisMin: -10,
      dataSet: traceCosine,
    );

    // Generate the Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text("OscilloScope Demo"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 1, child: scopeOne),
          Expanded(
            flex: 1,
            child: scopeTwo,
          ),
        ],
      ),
    );
  }

}


