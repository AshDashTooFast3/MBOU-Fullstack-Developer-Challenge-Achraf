import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/category.dart';

class ApiService {
  ApiService();

  final String baseUrl = 'http://127.0.0.1:8000';

  // ...

 Future<List<Category>> fetchCategories() async {
    final http.Response response = await http.get(
      Uri.parse('$baseUrl/api/categories'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load categories: ${response.statusCode}');
    }

    final dynamic decoded = json.decode(response.body);

    // Hangt af van je Laravel response structuur:
    List<dynamic> categories;

    if (decoded is List) {
      // Response is direct een lijst: [...]
      categories = decoded;
    } else if (decoded is Map && decoded.containsKey('data')) {
      // Response heeft 'data' key: {"data": [...]}
      categories = decoded['data'] ?? [];
    } else {
      throw Exception('Unexpected response format: ${response.body}');
    }

    print('Response body: ${response.body}');
    print('Status code: ${response.statusCode}');

    return categories.map((category) => Category.fromJson(category)).toList();
  }

  

  Future saveCategory(id, name) async {
    String url = '$baseUrl/api/categories/$id';
    final http.Response response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'name': name}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update category');
    }
  }

}

