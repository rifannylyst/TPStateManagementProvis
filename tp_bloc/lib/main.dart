import 'package:flutter/material.dart';
import 'employee.dart';
import 'employee_bloc.dart';
import 'employee_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee App',
      home: EmployeePage(),
    );
  }
}

class EmployeePage extends StatefulWidget {
  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final EmployeeRepository _employeeRepository = EmployeeRepository();
  final EmployeeBloc _employeeBloc = EmployeeBloc(EmployeeRepository());

  @override
  void initState() {
    super.initState();
    _employeeBloc.fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: StreamBuilder<List<Employee>>(
        stream: _employeeBloc.employees,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Employee employee = snapshot.data![index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle:
                      Text('Salary: ${employee.salary} - Age: ${employee.age}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _employeeBloc.dispose();
  }
}
