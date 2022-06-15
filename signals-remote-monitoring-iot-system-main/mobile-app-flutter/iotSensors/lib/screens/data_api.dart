import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iotsensors/models/readings_model.dart';
import 'dart:convert';


class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key}) : super(key: key);
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {

  late Future<List<sensorReading>> _future;
  Timer? _timer;

  Future<List<sensorReading>> getRequest() async {
    //replace your restFull API here.
    String url = "https://mighty-headland-68010.herokuapp.com/getsensors";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    //Creating a list to store input data;
    List<sensorReading> readings = [];
    // for (var reading in responseData) {
    sensorReading item = sensorReading(
          temp_value: responseData["temp_value"],
          hum_value: responseData["hum_value"],
          InDtTm: responseData["InDtTm"]);
          // readings;
    readings.add(item);
    // }
    // _isLoading = true;
    return readings;
  }


  setUpTimedFetch() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _future = getRequest();
      });
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }



  @override
  void initState() {
    // _isLoading = true;
    super.initState();
    _future = getRequest();
    setUpTimedFetch();
    // _isLoading = false;
  }

  // @override
  // void dispose() {
  //   getRequest()!.cancel();
  //   super.dispose();
  // }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("LATEST READINGS REFRESH"),
          leading: const Icon(
            Icons.wifi,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),

          child:
          FutureBuilder(
            future: _future,
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xff0000FF),  ),
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


        )



      ),
    );
  }


}




