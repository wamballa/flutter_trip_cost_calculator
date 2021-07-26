import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  String result = "";
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
  final double _formDistance = 5.0;
  String _currency = 'Dollars';
  TextEditingController _distanceController = TextEditingController();
  TextEditingController _averageController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reset();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? _textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Cost Calculator"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: _formDistance,
                  bottom: _formDistance,
                ),
                child: TextField(
                  controller: _distanceController,
                  decoration: InputDecoration(
                    labelText: 'Distance (miles)',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    hintText: "e.g 17",
                    labelStyle: _textStyle,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _formDistance,
                  bottom: _formDistance,
                ),
                child: TextField(
                  controller: _averageController,
                  decoration: InputDecoration(
                    labelText: 'Miles per Gallon',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    hintText: "e.g 25",
                    labelStyle: _textStyle,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    top: _formDistance,
                    bottom: _formDistance,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            labelText: 'Price per Gallon',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            hintText: "e.g 1.4",
                            labelStyle: _textStyle,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Container(
                        width: _formDistance * 5,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                            items: _currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                            value: _currency,
                            onChanged: (String? value) {
                              _onDropDownChanged(value!);
                            }),
                      ),
                    ],
                  )),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                          return Colors.red;
                        }),
                      ),
                      onPressed: () {
                        setState(() {
                          result = _calculate();
                        });
                      },
                      child: Text(
                        'Submit',
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    width: _formDistance * 5,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                          return Colors.grey;
                        }),
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                      child: Text(
                        'Reset',
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              Text(result),
            ],
          )),
    );
  }

  _onDropDownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  String _calculate() {
    double _distance = double.parse(_distanceController.text);
    double _fuelCost = double.parse(_priceController.text);
    double _consumption = double.parse(_averageController.text);
    double _totalCost = _distance / _consumption * _fuelCost;
    String _result = 'The total cost of  your trip is ' +
        _totalCost.toStringAsFixed(2) +
        ' ' +
        _currency;
    return _result;
  }

  void _reset() {
    _distanceController.text = '';
    _averageController.text = '';
    _priceController.text = '';
  }
}
