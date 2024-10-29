import 'package:exerapp/models/exercise.dart';
import 'package:exerapp/provider/exercise_provider.dart';
import 'package:exerapp/widgets/category_drawer.dart';
import 'package:exerapp/widgets/exercise_card.dart';
import 'package:exerapp/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  ExerciseCategory? selectedCategory;
  bool isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios de Programación'),
      ),
      drawer: CategoryDrawer(
        key: const Key('categoryDrawer'),
        selectedCategory: selectedCategory,
        onCategorySelected: (category) {
          setState(() {
            selectedCategory = category;
          });
          Navigator.pop(context);
        },
      ),
      body: Consumer<ExerciseProvider>(
        builder: (context, exerciseProvider, child) {
          final filteredExercises =
              exerciseProvider.searchExercises(searchQuery, selectedCategory);

          return Column(
            children: [
              // Show search bar if isSearchVisible is true
              if (isSearchVisible)
                CustomSearchBar(
                  onSearch: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                ),

              // Chips de filtros activos
              if (selectedCategory != null || searchQuery.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      if (selectedCategory != null)
                        FilterChip(
                          label: Text(selectedCategory!.name),
                          onDeleted: () {
                            setState(() {
                              selectedCategory = null;
                            });
                          },
                          onSelected: (bool value) {},
                        ),
                      if (searchQuery.isNotEmpty)
                        FilterChip(
                          label: Text('"$searchQuery"'),
                          onDeleted: () {
                            setState(() {
                              searchQuery = '';
                            });
                          },
                          onSelected: (bool value) {},
                        ),
                    ],
                  ),
                ),
              Expanded(
                child: filteredExercises.isEmpty
                    ? const Center(
                        child: Text('No se encontraron ejercicios'),
                      )
                    : ListView.builder(
                        itemCount: filteredExercises.length,
                        itemBuilder: (context, index) {
                          return ExerciseCard(
                            exercise: filteredExercises[index],
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isSearchVisible = !isSearchVisible; // Toggle search visibility
            if (!isSearchVisible) {
              searchQuery = ''; // Clear search when hiding
            }
          });
        },
        child: Icon(isSearchVisible ? Icons.close : Icons.search),
      ),
    );
  }
}
