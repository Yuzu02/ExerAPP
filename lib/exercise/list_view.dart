import 'package:flutter/material.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({super.key});

  @override
  CustomListViewState createState() => CustomListViewState();
}

class CustomListViewState extends State<CustomListView> {
  final List<String> nombres = [
    "Samuel",
    "Valentina",
    "Santiago",
    "Alejandro",
    "Valeria",
    "Benjamin",
    "Gerardo",
    "Carlos",
    "David",
    "Sofia"
  ];

  final List<String> edades = [
    "18",
    "25",
    "32",
    "17",
    "24",
    "20",
    "27",
    "15",
    "19",
    "23"
  ];

  String selectedEdad = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Nombres"),
        backgroundColor: Colors.teal, // Change AppBar color
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: nombres.length,
              itemBuilder: (context, index) {
                return Card(
                  // Wrap ListTile inside a Card
                  child: ListTile(
                    leading: const Icon(Icons.person), // Add an icon
                    title: Text(
                      nombres[index],
                      style: const TextStyle(
                        color: Colors.teal, // Change text color
                        fontSize: 18, // Increase font size
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedEdad =
                            "Edad de ${nombres[index]}: ${edades[index]} años";
                      });
                    },
                  ),
                );
              },
            ),
          ),
          if (selectedEdad.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedEdad,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal, // Change text color
                ),
              ),
            ),
        ],
      ),
    );
  }
}
