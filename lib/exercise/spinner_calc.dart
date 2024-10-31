import 'package:flutter/material.dart';

class SpinnerWidget extends StatefulWidget {
  const SpinnerWidget({super.key});

  @override
  SpinnerWidgetState createState() => SpinnerWidgetState();
}

class SpinnerWidgetState extends State<SpinnerWidget> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  String _selectedOperation = "sumar";
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

    double result;
    switch (_selectedOperation) {
      case "sumar":
        result = firstValue + secondValue;
        break;
      case "restar":
        result = firstValue - secondValue;
        break;
      case "multiplicar":
        result = firstValue * secondValue;
        break;
      case "dividir":
        if (secondValue == 0) {
          setState(() {
            _result = "No se puede dividir entre 0";
          });
          return;
        }
        result = firstValue / secondValue;
        break;
      default:
        result = 0;
    }

    setState(() {
      _result = "Resultado: $result";
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
        DropdownButton<String>(
          value: _selectedOperation,
          items: [
            DropdownMenuItem(
              value: "sumar",
              child: Text("Sumar"),
            ),
            DropdownMenuItem(
              value: "restar",
              child: Text("Restar"),
            ),
            DropdownMenuItem(
              value: "multiplicar",
              child: Text("Multiplicar"),
            ),
            DropdownMenuItem(
              value: "dividir",
              child: Text("Dividir"),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _selectedOperation = value!;
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
