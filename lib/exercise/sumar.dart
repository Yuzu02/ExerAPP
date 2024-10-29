import 'package:flutter/material.dart';

class SumWidget extends StatefulWidget {
  const SumWidget({super.key});

  @override
  SumWidgetState createState() => SumWidgetState();
}

class SumWidgetState extends State<SumWidget> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  double? _result;

  void _sumValues() {
    final double? firstValue = double.tryParse(_firstController.text);
    final double? secondValue = double.tryParse(_secondController.text);

    if (firstValue != null && secondValue != null) {
      setState(() {
        _result = firstValue + secondValue;
      });
    } else {
      setState(() {
        _result = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter valid numbers")),
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
            labelText: 'Dame el primer valor',
          ),
        ),
        TextField(
          controller: _secondController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Dame el segundo valor',
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _sumValues,
          child: Text('SUMAR'),
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
