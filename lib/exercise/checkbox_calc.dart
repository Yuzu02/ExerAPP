import 'package:flutter/material.dart';

class CheckBoxCalc extends StatefulWidget {
  const CheckBoxCalc({super.key});

  @override
  CheckBoxCalcState createState() => CheckBoxCalcState();
}

class CheckBoxCalcState extends State<CheckBoxCalc> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  bool _isSumChecked = false;
  bool _isSubtractChecked = false;
  String _result = "";

  void _calculate() {
    final double? firstValue = double.tryParse(_firstController.text);
    final double? secondValue = double.tryParse(_secondController.text);

    if (firstValue == null || secondValue == null) {
      setState(() {
        _result = "Por favor ingresa números válidos";
      });
      return;
    }

    String resultText = "";
    if (_isSumChecked) {
      double sum = firstValue + secondValue;
      resultText += "La suma es: $sum";
    }
    if (_isSubtractChecked) {
      double difference = firstValue - secondValue;
      resultText += _isSumChecked
          ? " / La resta es: $difference"
          : "La resta es: $difference";
    }

    setState(() {
      _result = resultText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _firstController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Primer valor',
          ),
        ),
        TextField(
          controller: _secondController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Segundo valor',
          ),
        ),
        SizedBox(height: 20),
        CheckboxListTile(
          title: Text("Sumar"),
          value: _isSumChecked,
          onChanged: (value) {
            setState(() {
              _isSumChecked = value!;
            });
          },
        ),
        CheckboxListTile(
          title: Text("Restar"),
          value: _isSubtractChecked,
          onChanged: (value) {
            setState(() {
              _isSubtractChecked = value!;
            });
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _calculate,
          child: Text('CALCULAR'),
        ),
        SizedBox(height: 20),
        Text(
          _result,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
