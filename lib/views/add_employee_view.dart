import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opstest_payroll_project/cubit/employee_cubit.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final hourlyRateController = TextEditingController();

    return BlocProvider(
      create: (context) => EmployeeCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Employee'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: hourlyRateController,
                decoration: const InputDecoration(labelText: 'Hourly Rate'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final hourlyRate = double.tryParse(hourlyRateController.text);
                  if (name.isNotEmpty && hourlyRate != null) {
                    // Add logic to save the new employee
                    final employee =
                        Employee(name: name, hourlyRate: hourlyRate);
                    context.read<EmployeeCubit>().addEmployee(employee);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Employee added successfully')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid input')),
                    );
                  }
                },
                child: const Text('Add Employee'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
