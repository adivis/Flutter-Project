import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double xA, yA, zA, xG, yG, zG, x1, y1, z1;
  //double x, y, z;

  var _sensors = <String>['accelerometer', 'gyroscope'];
  String _selectedSensor = 'accelerometer'; // _sensors[0];

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent eventA) {
      setState(() {
        xA = eventA.x;
        yA = eventA.y;
        zA = eventA.z;
        x1 = eventA.x;
        y1 = eventA.y;
        z1 = eventA.z;
      });
    }); //get the sensor data and set then to the data types

    gyroscopeEvents.listen((GyroscopeEvent eventG) {
      setState(() {
        xG = eventG.x;
        yG = eventG.y;
        zG = eventG.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Sensor Library"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Select the sensor from the dropdown list",
                  style:
                      TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
                ),
              ),
              DropdownButton<String>(
                items: _sensors.map((String elem) {
                  return DropdownMenuItem<String>(
                    value: elem,
                    child: Text(elem),
                  );
                }).toList(),
                onChanged: (String val) {
                  setState(() {
                    // updating the state
                    _selectedSensor = val;

                    if (_selectedSensor == 'accelerometer') {
                      x1 = xA;
                      y1 = yA;
                      z1 = zA;
                    }
                    if (_selectedSensor == 'gyroscope') {
                      x1 = xG;
                      y1 = yG;
                      z1 = zG;
                    }
                    // xA = x1;
                    // yA = y1;
                    // zA = z1;
                  });
                },
                value: _selectedSensor,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              Table(
                border: TableBorder.all(
                    width: 2.0,
                    color: Colors.blueAccent,
                    style: BorderStyle.solid),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "X axis: ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            x1.toStringAsFixed(
                                2), //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Y axis: ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            y1.toStringAsFixed(
                                2), //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Z axis: ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            z1.toStringAsFixed(
                                2), //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
