// Cubit States
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:opstest_payroll_project/models/employee.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// Cubit
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // Simulate an API call
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await http.post(
          Uri.parse('https://www.yahshuapayroll.com/api/api-auth/'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            'username': email,
            'password': password,
          }));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthError('Invalid credentials'));
      }
    } catch (e) {
      emit(AuthError('An error occurred'));
    }
  }
}
