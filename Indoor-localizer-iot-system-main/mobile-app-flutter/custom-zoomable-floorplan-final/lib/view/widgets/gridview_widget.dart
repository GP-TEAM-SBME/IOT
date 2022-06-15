import 'package:custom_zoomable_floorplan/core/models/readings_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:ui';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({key}) : super(key: key);
  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  GlobalKey _paintKey = new GlobalKey();
  GlobalKey _paintKeyHistory = new GlobalKey();
  Timer? _timer;
  late sensorReading _future;
  late sensorReading future;
  List<sensorReading> pointsList = [];
  List<sensorReading> historyList = []; // last point in pointsList if < 5 or return the last 5 elements

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }


  late StreamController _userController;

  Future fetchReading() async{
    String ourApi = "https://mighty-headland-68010.herokuapp.com/getsensors";
    final response = await http.get(Uri.parse(ourApi));
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      print("Exception caught: Failed to get data");
    }
  }

  loadReading() async{
    fetchReading().then((res) async{
      _future = sensorReading(
          temp_value: (res["temp_value"]).toDouble(),
          hum_value: (res["hum_value"]).toDouble(),
          InDtTm: res["InDtTm"]);
      future = _future;
      // pointsList.add(future);
      if ( !( (future.temp_value == pointsList.last.temp_value)
         && (future.hum_value == pointsList.last.hum_value) ) ){

        pointsList.add(future);

        if (pointsList.length >= 5) {
          historyList =  pointsList.sublist(pointsList.length - 5) ;
        } else {
          historyList =  pointsList.sublist(pointsList.length - 1) ;
        }
        _counter.value += 1;
        _userController.add(res);
        return res;

      }
      // else{
      //   // point
      //
      // }
    });
  }

  @override
  void initState() {
    super.initState();
    sensorReading initLate = sensorReading(temp_value: 2.2 , hum_value: 3.8  , InDtTm: "2022-03-09 14:27:53");
    future = sensorReading(temp_value: 2.2 , hum_value: 3.8  , InDtTm: "2022-03-09 14:27:53");
    pointsList.add(future);
    OpenPainter(initLate);
    _userController = StreamController();
    Timer.periodic(Duration(milliseconds: 1000), (Timer t){
        loadReading();
    });
  }
  //     this.x = 1.6 ;  // 2.8 < +ve ,  -ve > -1.3    center:0.75
  //     this.y = 2.0 ;  // 11  < up  , down > -0.5    center:5.25

      /*####################### LUT #########################*/
      //    '3201 upper left'    > lh32 x:-0.8   y: 7.8
      //    '3201 upper right'   > lh33 x:-0.2   y: 7.8
      //    '3201 lower left'    > lh34 x:-0.8   y: 9.0
      //    '3201 lower right'   > lh31 x:-0.2   y: 9.0
      //    'HW 11'              >      x: 0.6   y: 8.8
      //    'HW 12'              >      x: 0.6   y: 7.6
      //    'HW 21'              >      x: 2.0   y: 6.6
      //    'HW 22'              >      x: 0.6   y: 6.6
      //    'HW 23'              >      x:-0.5   y: 6.6
      //    'HW 31'              >      x: 0.6   y: 5.0
      //    'HW 32'              >      x: 0.6   y: 3.0
      //    'HW 33'              >      x: 0.6   y: 0.8
      //    'EL 11'              >      x: 2.2   y: 3.8
      //    'EL 12'              >      x: 1.2   y: 3.8
      //    'TAMER 11'           >      x: 1.6   y: 2.0
      //    'TA 11'              >      x: 1.5   y: 5.8
      /*#################### End LUT #########################*/

  // 2.2  3.8

  // 1.2  3.8
  // 0.6  3
  // 0.6  5
  // .6   6.6
  // .6   7.6
  // .6   8.8
  // .6   7.6
  // .6   6.6
  //-.5  6.6



  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Image.asset('images/ourfloor.jpeg',
        height: 600,
        width:400,
        ),
      ),
      Center(
        // add button if pressed call new HistoryPainter draw point by point
          child: Container(
            width: 400,
            height: 640,
            child: ValueListenableBuilder<int>(
            builder: (BuildContext context, int value, _ ) {

              return new CustomPaint(
                // key: _paintKey,
                key: _paintKeyHistory,
                // painter: new OpenPainter(future),
                painter: new HistoryPainter(historyList),
              );
             },
            valueListenable: _counter,
            )
          )
      ),
    ]);
  }
}

class OpenPainter extends CustomPainter {
  sensorReading lastReading;
  OpenPainter(this.lastReading);
  double y = 580, x = 217;
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round //rounded points
      ..strokeWidth = 10;
    var paintRed = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round //rounded points
      ..strokeWidth = 10;
    //list of points
    var points = [
      Offset(x - (lastReading.temp_value *50) , y - (lastReading.hum_value * 50) )
    ];
    // var pointsRed = [
      // Offset(x - (2 *50) , y - (5 * 50) ),
      // Offset(x - (2 *50) , y - (6 * 50) ),
      // Offset(x - (2 *50) , y - (7 * 50) ),
      // Offset(x - (1 *50) , y - (7 * 50) ),
    // ];
    //draw points on canvas
    canvas.drawPoints(PointMode.points, points, paint1);
    // canvas.drawPoints(PointMode.points, pointsRed, paintRed);
    // print('x:${lastReading.temp_value.toDouble()}, y:${lastReading.hum_value.toDouble()}' );
  }
  @override
  bool shouldRepaint(OpenPainter other) => other.lastReading != lastReading;
}

delay() async {
    await Future.delayed(Duration(seconds: 3));
    print('Wait 3 seconds');
}


class HistoryPainter extends CustomPainter {
  List<sensorReading> pointsReadings;
  HistoryPainter(this.pointsReadings);
  double y = 580, x = 217;
  @override
  void paint(Canvas canvas, Size size) {
    var paintGreen = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round //rounded points
      ..strokeWidth = 10;
    var paintRed = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round //rounded points
      ..strokeWidth = 10;
    //list of points
    var points = [
      Offset(x - (pointsReadings.last.temp_value  *50) , y - (pointsReadings.last.hum_value  * 50) )
    ];
    if ( pointsReadings.length == 5 ){
      var pointsRed3 = [
        Offset(x - (pointsReadings[3].temp_value  *50) , y - (pointsReadings[3].hum_value  * 50) ),
      ];
      var pointsRed2 = [
        Offset(x - (pointsReadings[2].temp_value  *50) , y - (pointsReadings[2].hum_value  * 50) ),
      ];
      var pointsRed1 = [
        Offset(x - (pointsReadings[1].temp_value  *50) , y - (pointsReadings[1].hum_value  * 50) ),
      ];
      var pointsRed0 = [
        Offset(x - (pointsReadings[0].temp_value  *50) , y - (pointsReadings[0].hum_value  * 50) ),
      ];

      // make a timer for reply
      canvas.drawPoints(PointMode.points, pointsRed0, paintRed);
      delay();
      canvas.drawPoints(PointMode.points, pointsRed1, paintRed);
      delay();
      canvas.drawPoints(PointMode.points, pointsRed2, paintRed);
      delay();
      canvas.drawPoints(PointMode.points, pointsRed3, paintRed);
      delay();
      canvas.drawPoints(PointMode.points, points, paintGreen);
    }else{
      canvas.drawPoints(PointMode.points, points, paintGreen);
    }

    // print('x:${pointsReadings.temp_value }, y:${pointsReadings.hum_value }' );
  }
  @override
  bool shouldRepaint(HistoryPainter other) => other.pointsReadings != pointsReadings;
}
