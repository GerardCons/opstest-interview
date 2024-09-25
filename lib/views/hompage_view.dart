import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opstest_payroll_project/cubit/auth_cubit.dart';
import 'package:opstest_payroll_project/views/add_employee_view.dart';

class ReadEmployeePage extends StatelessWidget {
  const ReadEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Details'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Company: YAHSHUA Demo Company',
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text('Admin: Amot, Andy A.', style: TextStyle(fontSize: 20)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEmployeePage(),
                      ),
                    );
                  },
                  child: Text("Add Employee")),
            ],
          )),
    );
  }
}
