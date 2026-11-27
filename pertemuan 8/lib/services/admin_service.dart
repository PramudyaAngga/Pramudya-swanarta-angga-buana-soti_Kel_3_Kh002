import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/admin.dart';

class AdminService {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com';

  // JSONPlaceholder tidak menyediakan endpoint admin. Data /users dipetakan
  // menjadi Admin; company.name digunakan sebagai department.
  Future<List<Admin>> getAdmins() async {
    final response = await http.get(Uri.parse('$_baseUrl/users'));
    _ensureSuccess(response);
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => Admin.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Admin> getAdmin(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/users/$id'));
    _ensureSuccess(response);
    return Admin.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<void> deleteAdmin(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/users/$id'));
    _ensureSuccess(response);
  }

  void _ensureSuccess(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Request gagal (${response.statusCode})');
    }
  }
}
