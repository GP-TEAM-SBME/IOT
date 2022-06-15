import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iotsensors/models/readings_model.dart';
import 'dart:convert';


class StaticApi extends StatefulWidget {
  const StaticApi({Key? key}) : super(key: key);
  @override
  _StaticApiState createState() => _StaticApiState();
}

class _StaticApiState extends State<StaticApi> {

   Future<List<sensorReading>> getRequest() async {
    // String url = "http://62.114.41.225:3000/getsensors";
    String url = "https://mighty-headland-68010.herokuapp.com/getsensors";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    
    List<sensorReading> readings = [];
    // for (var reading in responseData) {
    //   sensorReading item = sensorReading(
    //     temp_value: reading["temp_value"],
    //     hum_value: reading["hum_value"],
    //     InDtTm: reading["InDtTm"]);
    //
    // readings.add(item);
    // }
    sensorReading item = sensorReading(
            temp_value: responseData["temp_value"],
            hum_value: responseData["hum_value"],
            InDtTm: responseData["InDtTm"]);
    readings.add(item);


  return readings;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Http Get LATEST READINGS"),
          leading: const Icon(
            Icons.wifi,
          ),
        ),
        body:
        Container(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: getRequest(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xffFF0000),  ),
                  // child: Text("FAIIIIILLLLL"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) => ListTile(
                    title: Text('${snapshot.data[index].temp_value}'),
                    subtitle: Text('${snapshot.data[index].hum_value}'),
                    trailing: Text(snapshot.data[index].InDtTm),
                    contentPadding: const EdgeInsets.only(bottom: 20.0),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}





