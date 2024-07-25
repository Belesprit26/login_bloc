import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginState extends Equatable {
  final String pin;
  final List<Color> pinColors;

  const LoginState({required this.pin, required this.pinColors});

  @override
  List<Object> get props => [pin, pinColors];
}
