import 'package:flutter/material.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  CalculatorAppState createState() => CalculatorAppState();
}

class CalculatorAppState extends State<CalculatorApp> {
  String _output = '0';
  double _num1 = 0;
  String _operand = '';
  bool _newNumber = true;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '0';
        _num1 = 0;
        _operand = '';
        _newNumber = true;
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '×' ||
          buttonText == '÷') {
        _num1 = double.parse(_output);
        _operand = buttonText;
        _newNumber = true;
      } else if (buttonText == '=') {
        double num2 = double.parse(_output);
        switch (_operand) {
          case '+':
            _output = (_num1 + num2).toString();
            break;
          case '-':
            _output = (_num1 - num2).toString();
            break;
          case '×':
            _output = (_num1 * num2).toString();
            break;
          case '÷':
            _output = (_num1 / num2).toString();
            break;
        }
        _newNumber = true;
      } else {
        if (_newNumber) {
          _output = buttonText;
          _newNumber = false;
        } else {
          _output += buttonText;
        }
      }
    });
  }

  Widget _buildButton(String buttonText, {Color color = Colors.deepPurple}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => _onButtonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Text(
              _output,
              style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Expanded(
            child: Table(
              children: [
                TableRow(children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('÷', color: Colors.deepOrange),
                ]),
                TableRow(children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('×', color: Colors.deepOrange),
                ]),
                TableRow(children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-', color: Colors.deepOrange),
                ]),
                TableRow(children: [
                  _buildButton('0'),
                  _buildButton('.'),
                  _buildButton('=', color: Colors.deepOrange),
                  _buildButton('+', color: Colors.deepOrange),
                ]),
                TableRow(children: [
                  _buildButton('C', color: Colors.redAccent),
                  Container(),
                  Container(),
                  Container(),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
