import 'package:flutter/material.dart';

class RadioButtonWidget extends StatefulWidget {
  const RadioButtonWidget({super.key});

  @override
  RadioButtonWidgetState createState() => RadioButtonWidgetState();
}

class RadioButtonWidgetState extends State<RadioButtonWidget> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  String _operation = "sum"; // Default to sum
  double? _result;

  void _calculate() {
    final double? firstValue = double.tryParse(_firstController.text);
    final double? secondValue = double.tryParse(_secondController.text);

    if (firstValue != null && secondValue != null) {
      setState(() {
        if (_operation == "sum") {
          _result = firstValue + secondValue;
        } else if (_operation == "subtract") {
          _result = firstValue - secondValue;
        }
      });
    } else {
      setState(() {
        _result = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor ingresa números válidos")),
      );
    }
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
        Row(
          children: [
            Radio<String>(
              value: "sum",
              groupValue: _operation,
              onChanged: (value) {
                setState(() {
                  _operation = value!;
                });
              },
            ),
            Text("Sumar"),
            Radio<String>(
              value: "subtract",
              groupValue: _operation,
              onChanged: (value) {
                setState(() {
                  _operation = value!;
                });
              },
            ),
            Text("Restar"),
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
