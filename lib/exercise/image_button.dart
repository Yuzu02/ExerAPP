import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImageButtonScreen extends StatelessWidget {
  const ImageButtonScreen({super.key});

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Botones de Imagen'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centra horizontalmente
          children: [
            // Primer botón
            GestureDetector(
              onTap: () => showToast("Logo de Vardemon"),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  // Centra la imagen dentro del contenedor
                  child: Image.asset(
                    'assets/images/vardemon_icon.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Espacio entre los botones
            // Segundo botón
            GestureDetector(
              onTap: () => showToast("Esto es una mano"),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  // Centra la imagen dentro del contenedor
                  child: Image.asset(
                    'assets/images/hand.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
