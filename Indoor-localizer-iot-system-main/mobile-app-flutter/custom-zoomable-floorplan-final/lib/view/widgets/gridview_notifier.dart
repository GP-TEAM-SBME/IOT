import 'package:custom_zoomable_floorplan/core/models/readings_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:ui';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;




class GridViewWidgetNotifier extends StatefulWidget {
  const GridViewWidgetNotifier({key}) : super(key: key);

  @override
  _GridViewWidgetNotifierState createState() => _GridViewWidgetNotifierState();
}

class _GridViewWidgetNotifierState extends State<GridViewWidgetNotifier> {

  late ValueNotifier<sensorReading> _notifier;
  Timer? _pollTimer;


  // OpenPainter painter = new OpenPainter();
  double x = 0, y = 0;

  // late Future<sensorReading> _future;
  // Timer? _timer;

  Future<sensorReading> getRequest() async {
    String url = "https://mighty-headland-68010.herokuapp.com/getsensors";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);

    // List<sensorReading> readings = [];

    sensorReading item = new sensorReading(
        temp_value: responseData["temp_value"],
        hum_value: responseData["hum_value"],
        InDtTm: responseData["InDtTm"]
    );

    // readings.add(item);

    // this.painter.move( (item.temp_value).toDouble() , (item.hum_value).toDouble()   );
    // return readings;
    return item;
  }

  // setUpTimedFetch() {
  //   _timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
  //     setState(() {
  //       _future = getRequest();
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   _timer!.cancel();
  //   super.dispose();
  // }


  getRequestInit() async {
    sensorReading lastReading = await getRequest() ;
    return lastReading;
  }


  @override
  void initState(){
    super.initState();
    // sensorReading lastReading = await getRequest() ;

    _notifier =  ValueNotifier( getRequestInit() );
    // _future = getRequest();
    _pollTimer = Timer.periodic(Duration(milliseconds: 2000), _pollOffset);

    // setUpTimedFetch();
  }


  _pollOffset(Timer t) {
    setState(() async {
     sensorReading lastReading = await getRequestInit() ;
    _notifier.value =  lastReading;
    // _future = getRequest();
    // print('polled: ${(_notifier.value.temp_value).toDouble()} , ${(_notifier.value.hum_value).toDouble()}' );
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
            child: CustomPaint(
                    painter: OpenPainter(
                      context: context,
                      notifier: _notifier,
                    ),
                  ),
        )
      ),
    ]);
  }
}




class OpenPainter extends CustomPainter {
  ValueNotifier<sensorReading> notifier;
  BuildContext context;

  OpenPainter( {required this.context, required this.notifier} ) : super(repaint: notifier);

  @override
  bool shouldRepaint(OpenPainter old) {
    return true;
  }

  double y = 580, x = 217;
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round //rounded points
      ..strokeWidth = 10;
    //list of points
    var points = [
      Offset( x - ( (notifier.value.temp_value).toDouble() * 50)  , y - ( (notifier.value.hum_value).toDouble() * 50 ) ),
    ];

    canvas.drawPoints(PointMode.points, points, paint1);
  }

  // void move(double x, double y) {
  //   this.y = 580 - y * 50;
  //   this.x = 217 - x * 50;
  // }
}
