class Employee {
  final String name;
  final String pin;

  Employee({required this.name, required this.pin});
}

final List<Employee> employees = [
  Employee(name: 'John Doe', pin: '1234'),
  Employee(name: 'Jane Smith', pin: '2345'),
  Employee(name: 'James Brown', pin: '3456'),
  Employee(name: 'Judy Wilson', pin: '4567'),
  Employee(name: 'Jack White', pin: '5678'),
];