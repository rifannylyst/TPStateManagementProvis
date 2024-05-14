import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'employee_provider.dart';
import 'employee_form_screen.dart';
import 'create_employee_screen.dart'; // Import file create_employee_screen.dart di sini

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmployeeProvider()),
      ],
      child: MaterialApp(
        title: 'Employee App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Tambahkan rute untuk CreateEmployeeScreen di sini
        initialRoute: '/',
        routes: {
          '/': (ctx) => EmployeeListScreen(),
          '/create': (ctx) => CreateEmployeeScreen(),
        },
      ),
    );
  }
}

class EmployeeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => EmployeeFormScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                  '/create'); // Ganti dengan rute menuju CreateEmployeeScreen
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<EmployeeProvider>(context, listen: false)
            .fetchEmployees(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            print('Snapshot Error: ${snapshot.error}');
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<EmployeeProvider>(
              builder: (ctx, employeeProvider, child) => ListView.builder(
                itemCount: employeeProvider.employees.length,
                itemBuilder: (ctx, i) => ListTile(
                  title: Text(employeeProvider.employees[i].name),
                  subtitle: Text(
                      'Age: ${employeeProvider.employees[i].age}, Salary: ${employeeProvider.employees[i].salary}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => EmployeeFormScreen(
                                  employee: employeeProvider.employees[i]),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<EmployeeProvider>(context, listen: false)
                              .deleteEmployee(employeeProvider.employees[i].id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
