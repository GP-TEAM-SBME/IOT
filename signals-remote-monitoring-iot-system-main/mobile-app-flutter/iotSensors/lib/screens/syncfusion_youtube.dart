import 'dart:async';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class LiveLineChart extends StatefulWidget {
  const LiveLineChart({Key? key}) : super(key: key);

  @override
  _LiveLineChartState createState() => _LiveLineChartState();
}

class _LiveLineChartState extends State<LiveLineChart> {

  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;
  Timer? _timer;

  @override
  void initState(){
    super.initState();
    chartData = getChartData();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), updateDataSource);
    }

  List<LiveData> getChartData(){
    return <LiveData>[
      LiveData(0, 37),
      LiveData(1, 38),
      LiveData(2, 39),
      LiveData(3, 40),
      LiveData(4, 42),
      LiveData(5, 42),
      LiveData(6, 41),
      LiveData(7, 40),
      LiveData(8, 39),
      LiveData(9, 38),
    ];
  }

  int time = 10;
  updateDataSource(Timer timer) async{
    String url = "https://mighty-headland-68010.herokuapp.com/getsensors";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);

    // chartData.add( LiveData( time++, ( math.Random().nextInt(60)  )));
    chartData.add( LiveData( time++, ( responseData["temp_value"] ) ));

    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
      addedDataIndex: chartData.length-1, removedDataIndex:0
    );
  }


  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Chart"),
      ),
      body: SizedBox(
        height: 400,
        child: SfCartesianChart(
          series: [
            LineSeries<LiveData, int>(
              onRendererCreated: (ChartSeriesController controller){
                _chartSeriesController = controller;
              },
              dataSource: chartData,
              xValueMapper: (LiveData data, _)=> data.time,
              yValueMapper: (LiveData data, _)=> data.speed,
            )
          ],
        ),
      ),
    );

  }
}

class LiveData {
  final int time;
  final num speed;
  LiveData(this.time, this.speed);
}