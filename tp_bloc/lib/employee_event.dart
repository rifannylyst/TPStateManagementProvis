import 'package:equatable/equatable.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class FetchEmployees extends EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final String name;
  final String salary;
  final String age;

  const AddEmployee(this.name, this.salary, this.age);

  @override
  List<Object> get props => [name, salary, age];
}
