import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_task_model.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<ApiTask>> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/todos'));

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((item) => ApiTask.fromJson(item)).toList();
      } else {
        throw Exception('Falha ao carregar tarefas da API');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}