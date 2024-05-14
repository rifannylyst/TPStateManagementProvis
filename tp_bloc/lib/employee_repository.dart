import 'dart:convert';
import 'package:http/http.dart' as http;
import 'employee.dart';

class EmployeeRepository {
  Future<List<Employee>> fetchEmployees() async {
    try {
      final response = await http
          .get(Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];
        List<Employee> employees =
            jsonData.map((e) => Employee.fromJson(e)).toList();
        return employees;
      } else {
        throw Exception('Failed to load employees');
      }
    } catch (e) {
      throw Exception('Failed to load employees: $e');
    }
  }
}
