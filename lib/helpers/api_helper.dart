import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = "https://jsonplaceholder.typicode.com";

class ApiHelper {
  static Future<List<T>> fetchList<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<T> create<T>(String endpoint, Map<String, dynamic> body,
      T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.post(Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: json.encode(body));
    if (response.statusCode == 201) {
      return fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create');
    }
  }

  static Future<void> delete(String endpoint, int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete');
    }
  }
}
