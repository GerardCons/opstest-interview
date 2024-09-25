import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Employee Model
class Employee {
  final int? id;
  final String name;
  final double hourlyRate;

  Employee({this.id, required this.name, required this.hourlyRate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'hourly_rate': hourlyRate,
    };
  }
}

// Employee States
abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeAdded extends EmployeeState {}

class EmployeeError extends EmployeeState {
  final String message;
  EmployeeError(this.message);
}

// Employee Cubit
class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeInitial());

  Future<Database> _initializeDB() async {
    String path = join(await getDatabasesPath(), 'employee_database.db');
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE employees(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, hourly_rate REAL NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<void> addEmployee(Employee employee) async {
    emit(EmployeeLoading());
    try {
      final db = await _initializeDB();
      await db.insert('employees', employee.toMap());
      emit(EmployeeAdded());
    } catch (e) {
      emit(EmployeeError('An error occurred while adding the employee'));
    }
  }
}
