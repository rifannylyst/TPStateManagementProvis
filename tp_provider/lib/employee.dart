class Employee {
  final String id;
  final String name;
  final String salary;
  final String age;

  Employee({
    required this.id,
    required this.name,
    required this.salary,
    required this.age,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'].toString(),
      name: json['employee_name'],
      salary: json['employee_salary'].toString(),
      age: json['employee_age'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_name': name,
      'employee_salary': salary,
      'employee_age': age,
    };
  }
}
