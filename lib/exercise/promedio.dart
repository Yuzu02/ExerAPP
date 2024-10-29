import 'package:flutter/material.dart';

class StudentStatusWidget extends StatefulWidget {
  const StudentStatusWidget({super.key});

  @override
  StudentStatusWidgetState createState() => StudentStatusWidgetState();
}

class StudentStatusWidgetState extends State<StudentStatusWidget> {
  final TextEditingController _mathController = TextEditingController();
  final TextEditingController _physicsController = TextEditingController();
  final TextEditingController _chemistryController = TextEditingController();
  String _status = "";

  void _evaluateStatus() {
    final double? mathGrade = double.tryParse(_mathController.text);
    final double? physicsGrade = double.tryParse(_physicsController.text);
    final double? chemistryGrade = double.tryParse(_chemistryController.text);

    if (mathGrade != null && physicsGrade != null && chemistryGrade != null) {
      final double average = (mathGrade + physicsGrade + chemistryGrade) / 3;

      setState(() {
        if (average >= 6) {
          _status = "Aprobado";
        } else {
          _status = "Reprobado";
        }
      });
    } else {
      setState(() {
        _status = "Por favor ingresa calificaciones válidas";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estatus del Alumno',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: _mathController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Matemáticas',
          ),
        ),
        TextField(
          controller: _physicsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Física',
          ),
        ),
        TextField(
          controller: _chemistryController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Química',
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _evaluateStatus,
          child: Text('EVALUAR'),
        ),
        SizedBox(height: 20),
        Text(
          'Resultado: $_status',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
