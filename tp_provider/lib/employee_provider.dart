import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'employee.dart';

class EmployeeProvider with ChangeNotifier {
  List<Employee> _employees = [];

  List<Employee> get employees => _employees;

  Future<void> fetchEmployees() async {
    final url = 'https://dummy.restapiexample.com/api/v1/employees';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        if (extractedData['data'] != null) {
          final List<Employee> loadedEmployees = [];
          for (var emp in extractedData['data']) {
            loadedEmployees.add(Employee.fromJson(emp));
          }
          _employees = loadedEmployees;
          notifyListeners();
        } else {
          print('No data found');
        }

        // Optionally, add a delay and retry logic here
      } else {
        print('Failed to load employees: ${response.statusCode}');
        throw Exception('Failed to load employees');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }

  Future<void> addEmployee(Employee employee) async {
    final url = 'https://dummy.restapiexample.com/api/v1/create';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'name': employee.name,
          'salary': employee.salary,
          'age': employee.age,
        }),
      );
      if (response.statusCode == 200) {
        final newEmployee =
            Employee.fromJson(json.decode(response.body)['data']);
        _employees.add(newEmployee);
        notifyListeners();
      } else {
        print('Failed to add employee: ${response.statusCode}');
        throw Exception('Failed to add employee');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }

  Future<void> updateEmployee(String id, Employee employee) async {
    final url = 'https://dummy.restapiexample.com/api/v1/update/$id';
    try {
      final response = await http.put(
        Uri.parse(url),
        body: json.encode(employee.toJson()),
      );
      if (response.statusCode == 200) {
        final empIndex = _employees.indexWhere((emp) => emp.id == id);
        if (empIndex >= 0) {
          _employees[empIndex] = employee;
          notifyListeners();
        }
      } else {
        print('Failed to update employee: ${response.statusCode}');
        throw Exception('Failed to update employee');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }

  Future<void> deleteEmployee(String id) async {
    final url = 'https://dummy.restapiexample.com/api/v1/delete/$id';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        _employees.removeWhere((emp) => emp.id == id);
        notifyListeners();
      } else {
        print('Failed to delete employee: ${response.statusCode}');
        throw Exception('Failed to delete employee');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }

  Future<void> createEmployee(String name, String salary, String age) async {
    final url = 'https://dummy.restapiexample.com/api/v1/create';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'name': name,
          'salary': salary,
          'age': age,
        }),
      );
      if (response.statusCode == 200) {
        final createdEmployee =
            Employee.fromJson(json.decode(response.body)['data']);
        _employees.add(createdEmployee);
        notifyListeners();
      } else {
        print('Failed to create employee: ${response.statusCode}');
        throw Exception('Failed to create employee');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }
}
