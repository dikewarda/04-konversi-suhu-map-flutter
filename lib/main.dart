import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konversi_suhu/widget/result.dart';
import 'package:konversi_suhu/widget/input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  double _inputUser = 0;
  double _kelvin = 0;
  double _reamur = 0;
  double _fahrenheit = 0;

  var listItem = ["Kelvin", "Reamur", "Fahrenheit"];

  final inputController = TextEditingController();

  String _newValue = "Kelvin";
  double _result = 0;

  List<String> listViewItem = <String>[];

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Konversi Suhu - 2031710147 Dike Ayu Wardani',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Konversi Suhu - 2031710147 Dike Ayu Wardani"),
          ),
          body: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Input(inputController: inputController),
                Column(
                  children: [
                    DropdownButton<String>(
                      items: listItem.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _newValue,
                      onChanged: (String? changeValue) {
                        setState(() {
                          _newValue = changeValue!;
                        });
                        convert();
                      },
                    ),
                    Result(result: _result)
                  ],
                ),
                MaterialButton(
                  onPressed: () {
                    convert();
                  },
                  child: const Text(
                    "Konversi",
                    style: TextStyle(fontSize: 24),
                  ),
                  color: Colors.pink,
                  textColor: Colors.white,
                  minWidth: double.maxFinite,
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "Riwayat Konversi",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                    child: Column(
                        children: listViewItem.map((String value) {
                  return Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 15),
                      ));
                }).toList()))
              ],
            ),
          ),
        ));
  }

  void convert() {
    setState(() {
      _inputUser = double.parse(inputController.text);
      if (_newValue == "Kelvin") {
        _result = _inputUser + 273.15;
      } else if (_newValue == "Reamur") {
        _result = 0.8 * _inputUser;
      } else {
        _result = (_inputUser * 1.8) + 32;
      }
      listViewItem.add(_newValue + ": " + _result.toStringAsFixed(2));
    });
  }
}
