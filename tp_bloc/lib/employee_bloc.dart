import 'dart:async';
import 'employee.dart';
import 'employee_repository.dart';

class EmployeeBloc {
  final EmployeeRepository _employeeRepository;
  late List<Employee> _employees;

  final _employeeStreamController = StreamController<List<Employee>>();

  Stream<List<Employee>> get employees => _employeeStreamController.stream;

  EmployeeBloc(this._employeeRepository) {
    _employees = [];
    fetchEmployees();
  }

  void fetchEmployees() async {
    try {
      _employees = await _employeeRepository.fetchEmployees();
      _employeeStreamController.sink.add(_employees);
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    _employeeStreamController.close();
  }
}
