import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(title: const Text("Inicio"), onTap: () {}),
          ListTile(title: const Text("Ejercicios"), onTap: () {}),
          ListTile(title: const Text("Herramientas"), onTap: () {}),
        ],
      ),
    );
  }
}
