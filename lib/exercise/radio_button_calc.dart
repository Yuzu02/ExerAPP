import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RadioCalc extends StatefulWidget {
  const RadioCalc({super.key});

  @override
  RadioCalcState createState() => RadioCalcState();
}

class RadioCalcState extends State<RadioCalc> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  String _operation = "sum"; // Operación por defecto
  double? _result;

  void _calculate() {
    final double? firstValue = double.tryParse(_firstController.text);
    final double? secondValue = double.tryParse(_secondController.text);

    if (firstValue == null || secondValue == null) {
      Fluttertoast.showToast(msg: "Por favor ingresa números válidos");
      return;
    }

    setState(() {
      switch (_operation) {
        case "sum":
          _result = firstValue + secondValue;
          break;
        case "subtract":
          _result = firstValue - secondValue;
          break;
        case "multiply":
          _result = firstValue * secondValue;
          break;
        case "divide":
          if (secondValue == 0) {
            Fluttertoast.showToast(msg: "No se puede dividir entre 0");
            _result = null;
          } else {
            _result = firstValue / secondValue;
          }
          break;
      }
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
        Column(
          children: [
            RadioListTile<String>(
              title: Text("Sumar"),
              value: "sum",
              groupValue: _operation,
              onChanged: (value) {
                setState(() {
                  _operation = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text("Restar"),
              value: "subtract",
              groupValue: _operation,
              onChanged: (value) {
                setState(() {
                  _operation = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text("Multiplicar"),
              value: "multiply",
              groupValue: _operation,
              onChanged: (value) {
                setState(() {
                  _operation = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text("Dividir"),
              value: "divide",
              groupValue: _operation,
              onChanged: (value) {
                setState(() {
                  _operation = value!;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _calculate,
          child: Text('CALCULAR'),
        ),
        SizedBox(height: 20),
        Text(
          'Resultado: ${_result != null ? _result.toString() : ''}',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
