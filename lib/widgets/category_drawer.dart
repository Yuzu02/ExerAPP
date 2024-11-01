// lib/widgets/category_drawer.dart
import 'package:exerapp/models/exercise_category.dart';
import 'package:flutter/material.dart';

class CategoryDrawer extends StatelessWidget {
  final ExerciseCategory? selectedCategory;
  final Function(ExerciseCategory?) onCategorySelected;

  const CategoryDrawer({super.key, 
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categorías',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.clear_all),
            title: const Text('Todas las categorías'),
            selected: selectedCategory == null,
            onTap: () => onCategorySelected(null),
          ),
          ...ExerciseCategory.values.map((category) => ListTile(
                leading: Icon(category.icon),
                title: Text(category.name),
                selected: category == selectedCategory,
                onTap: () => onCategorySelected(category),
              )),
        ],
      ),
    );
  }
}
