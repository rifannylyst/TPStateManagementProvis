import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'employee_provider.dart';
import 'employee.dart';

class EmployeeFormScreen extends StatefulWidget {
  final Employee? employee;

  EmployeeFormScreen({this.employee});

  @override
  _EmployeeFormScreenState createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'name': '',
    'salary': '',
    'age': '',
  };

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _formData['name'] = widget.employee!.name;
      _formData['salary'] = widget.employee!.salary;
      _formData['age'] = widget.employee!.age;
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newEmployee = Employee(
        id: widget.employee != null
            ? widget.employee!.id
            : DateTime.now().toString(),
        name: _formData['name']!,
        salary: _formData['salary']!,
        age: _formData['age']!,
      );
      if (widget.employee != null) {
        Provider.of<EmployeeProvider>(context, listen: false)
            .updateEmployee(widget.employee!.id, newEmployee);
      } else {
        Provider.of<EmployeeProvider>(context, listen: false)
            .addEmployee(newEmployee);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee != null ? 'Edit Employee' : 'Add Employee'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Name'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _formData['name'] = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['salary'],
                decoration: InputDecoration(labelText: 'Salary'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _formData['salary'] = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a salary.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['age'],
                decoration: InputDecoration(labelText: 'Age'),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _formData['age'] = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an age.';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
