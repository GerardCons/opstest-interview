class Employee {
  final String name;
  final double hourlyRate;

  Employee({required this.name, required this.hourlyRate});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      hourlyRate: json['hourly_rate'].toDouble(),
    );
  }
}
