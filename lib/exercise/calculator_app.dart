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
          _output = _output + buttonText;
        }
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24),
          ),
          onPressed: () => _onButtonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Text(
            _output,
            style: const TextStyle(fontSize: 48),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Row(children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('÷'),
              ]),
              Row(children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('×'),
              ]),
              Row(children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
              ]),
              Row(children: [
                _buildButton('0'),
                _buildButton('.'),
                _buildButton('='),
                _buildButton('+'),
              ]),
              Row(children: [
                _buildButton('C'),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
