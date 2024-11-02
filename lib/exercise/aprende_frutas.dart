import 'package:exerapp/constants/frutas.dart';
import 'package:exerapp/utils/toast.dart';
import 'package:flutter/material.dart';

class FruitGalleryColor extends StatelessWidget {
  const FruitGalleryColor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aprende con Frutas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade50,
        elevation: 4,
        shadowColor: Colors.black26,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: fruits.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, String> fruit = entry.value;
              return GestureDetector(
                onTap: () =>
                    showToast('Esto ${fruit['plural']} ${fruit['name']}'),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? Colors.white
                        : Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        fruit['image']!,
                        height: 140,
                        width: 140,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
