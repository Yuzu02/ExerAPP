import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SpinnerVtwo extends StatefulWidget {
  const SpinnerVtwo({super.key});

  @override
  SpinnerVtwoState createState() => SpinnerVtwoState();
}

class SpinnerVtwoState extends State<SpinnerVtwo> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  String _selectedOperation = "sumar";
  String _result = "";

  final List<String> _operations = [
    "sumar",
    "restar",
    "multiplicar",
    "dividir"
  ];

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _firstController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Primer valor',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _secondController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Segundo valor',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          DropdownButton2<String>(
            underline: Container(), // Esta línea elimina la línea horizontal
            items: _operations
                .map((operation) => DropdownMenuItem<String>(
                      value: operation,
                      child: Row(
                        children: [
                          Icon(
                            operation == _selectedOperation
                                ? Icons.check_circle
                                : Icons.circle,
                            color: operation == _selectedOperation
                                ? Colors.amber
                                : Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            operation.toUpperCase(),
                            style: TextStyle(
                              color: operation == _selectedOperation
                                  ? Colors.amber
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            value: _selectedOperation,
            onChanged: (value) {
              setState(() {
                _selectedOperation = value!;
              });
            },
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              elevation: 8,
              offset: const Offset(
                  0, -5), // Ajusta la posición del menú desplegable
              padding: EdgeInsets.symmetric(vertical: 8),
              scrollbarTheme: ScrollbarThemeData(
                thickness: WidgetStateProperty.all(6),
                thumbColor: WidgetStateProperty.all(Colors.amber),
              ),
            ),
            iconStyleData: IconStyleData(
              icon: Icon(Icons.arrow_drop_down, color: Colors.amber),
            ),
            buttonStyleData: ButtonStyleData(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.transparent),
              ),
              elevation: 0, // Asegura que no haya sombra
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calculate,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'CALCULAR',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Text(
            _result,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
