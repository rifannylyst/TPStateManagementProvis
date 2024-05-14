import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'employee_provider.dart';

class CreateEmployeeScreen extends StatefulWidget {
  @override
  _CreateEmployeeScreenState createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'name': '',
    'salary': '',
    'age': '',
  };

  void _saveForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<EmployeeProvider>(context, listen: false).createEmployee(
        _formData['name']!,
        _formData['salary']!,
        _formData['age']!,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveForm(context),
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
