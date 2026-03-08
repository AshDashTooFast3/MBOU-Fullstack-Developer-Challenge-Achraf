import 'package:flutter/material.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/services/api.dart';
import 'package:frontend/widgets/category_edit.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  CategoriesListState createState() => CategoriesListState();
}

class CategoriesListState extends State<CategoriesList> {
  Future<List<Category>>? futureCategories;
  final apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  late Category selectedCategory;
  final categoryNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureCategories = apiService.fetchCategories();  
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories List')),
      body: FutureBuilder<List<Category>>(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Category category = snapshot.data![index];
                return ListTile(
                  title: Text(category.name),
                  trailing: IconButton(
                    onPressed: () {

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return CategoryEdit(category);
                        },
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
