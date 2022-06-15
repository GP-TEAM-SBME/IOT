import 'package:custom_zoomable_floorplan/core/models/position.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:ui';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class PositionWidget extends StatefulWidget {
  const PositionWidget({key}) : super(key: key);

  @override
  _PositionWidgetState createState() => _PositionWidgetState();
}

class _PositionWidgetState extends State<PositionWidget> {

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  GlobalKey _paintKey = new GlobalKey();
  GlobalKey _paintKeyHistory = new GlobalKey();

  Timer? _timer;
  late positionOffset _future;
  late positionOffset future;
  List<positionOffset> pointsList = [];
  List<positionOffset> historyList = [];

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  late StreamController _userController;

  Future fetchReading() async{
    // String ourApi = "https://mighty-headland-68010.herokuapp.com/getsensors";
    String ourApi = "https://python-server-model.herokuapp.com/getdata";
    final response = await http.get(Uri.parse(ourApi));
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      print("Exception caught: Failed to get data");
    }
  }

  loadReading() async{
    fetchReading().then((res) async{
      _future = positionOffset(
          x_val_azoz: res["x_val_azoz"],
          x_val_seyam: res["x_val_seyam"],
          y_val_azoz: res["y_val_azoz"],
          y_val_seyam: res["y_val_seyam"],
      );
      future = _future;

      if ( !( (future.x_val_azoz.toDouble() == pointsList.last.x_val_azoz.toDouble())
          && (future.y_val_azoz.toDouble() == pointsList.last.y_val_azoz.toDouble()) ) ) {
        pointsList.add(future);

        if (pointsList.length >= 5) {
          historyList = pointsList.sublist(pointsList.length - 5);
        } else {
          historyList = pointsList.sublist(pointsList.length - 1);
        }
        _counter.value += 1;
        _userController.add(res);
        return res;

      }
    });
  }

  @override
  void initState() {
    super.initState();
    positionOffset initLate = positionOffset(x_val_azoz: 1, x_val_seyam: 0 , y_val_azoz: 5, y_val_seyam: 0);
    future                  = positionOffset(x_val_azoz: 1, x_val_seyam: 0 , y_val_azoz: 5, y_val_seyam: 0);
    pointsList.add(future);
    OpenPainter(initLate);
    _userController = StreamController();
    Timer.periodic(Duration(milliseconds: 1000), (Timer t){
      loadReading();
    });
  }


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
  positionOffset lastReading;
  OpenPainter(this.lastReading);
  double y = 580, x = 217;
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round //rounded points
      ..strokeWidth = 10;
    //list of points
    var points = [
      // Offset(this.x, this.y),
      Offset(x - (lastReading.x_val_azoz.toDouble() * 50) , y - (lastReading.y_val_azoz.toDouble() * 50) )
    ];
    canvas.drawPoints(PointMode.points, points, paint1);
    print('x:${lastReading.x_val_azoz.toDouble()}, y:${lastReading.y_val_azoz.toDouble()}');
  }
  @override
  bool shouldRepaint(OpenPainter other) => other.lastReading != lastReading;
}



class HistoryPainter extends CustomPainter {
  List<positionOffset> pointsReadings;
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
      Offset(x - (pointsReadings.last.x_val_azoz.toDouble() *50) , y - (pointsReadings.last.y_val_azoz.toDouble() * 50) )
    ];
    if ( pointsReadings.length == 5 ){
      var pointsRed3 = [
        Offset(x - (pointsReadings[3].x_val_azoz.toDouble() *50) , y - (pointsReadings[3].y_val_azoz.toDouble() * 50) ),
      ];
      var pointsRed2 = [
        Offset(x - (pointsReadings[2].x_val_azoz.toDouble() *50) , y - (pointsReadings[2].y_val_azoz.toDouble() * 50) ),
      ];
      var pointsRed1 = [
        Offset(x - (pointsReadings[1].x_val_azoz.toDouble() *50) , y - (pointsReadings[1].y_val_azoz.toDouble() * 50) ),
      ];
      var pointsRed0 = [
        Offset(x - (pointsReadings[0].x_val_azoz.toDouble() *50) , y - (pointsReadings[0].y_val_azoz.toDouble() * 50) ),
      ];

      // make a timer for reply
      canvas.drawPoints(PointMode.points, pointsRed0, paintRed);
      canvas.drawPoints(PointMode.points, pointsRed1, paintRed);
      canvas.drawPoints(PointMode.points, pointsRed2, paintRed);
      canvas.drawPoints(PointMode.points, pointsRed3, paintRed);
      canvas.drawPoints(PointMode.points, points, paintGreen);
    }else{
      canvas.drawPoints(PointMode.points, points, paintGreen);
    }

    // print('x:${pointsReadings.temp_value.toDouble()}, y:${pointsReadings.hum_value.toDouble()}' );
  }
  @override
  bool shouldRepaint(HistoryPainter other) => other.pointsReadings != pointsReadings;
}

