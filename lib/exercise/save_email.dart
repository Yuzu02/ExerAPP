import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailInputWidget extends StatefulWidget {
  const EmailInputWidget({super.key});

  @override
  EmailInputWidgetState createState() => EmailInputWidgetState();
}

class EmailInputWidgetState extends State<EmailInputWidget> {
  final TextEditingController _emailController = TextEditingController();
  String? _savedEmail;

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  // Cargar el email desde SharedPreferences al iniciar el widget
  Future<void> _loadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedEmail = prefs.getString('email') ?? '';
      _emailController.text = _savedEmail!;
    });
  }

  // Guardar el email en SharedPreferences
  Future<void> _saveEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    setState(() {
      _savedEmail = _emailController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _saveEmail,
            child: Text('Guardar'),
          ),
          const SizedBox(height: 16),
          if (_savedEmail != null)
            Text(
              'Email guardado: $_savedEmail',
              style: TextStyle(fontSize: 16),
            ),
        ],
      ),
    );
  }
}
