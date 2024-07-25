import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Color primaryAccentColor = Color(0xFFCCE8F6);
  final Color primaryColor = Color(0xFF008BD0);
  final Color secondaryColor = Color(0xFF84AE2B);
  final Color errorColor = Color(0xFFDE0B1C);

  LoginBloc() : super(LoginState(pin: '', pinColors: List.filled(4, Color(0xFFCCE8F6)))) {
    on<PinDigitPressed>((event, emit) {
      if (state.pin.length < 4) {
        final newPin = state.pin + event.digit;
        final newPinColors = List<Color>.from(state.pinColors);
        for (int i = 0; i < 4; i++) {
          newPinColors[i] = i < newPin.length ? primaryColor : primaryAccentColor;
        }
        emit(LoginState(pin: newPin, pinColors: newPinColors));
        if (newPin.length == 4) {
          _validatePin(newPin, emit);
        }
      }
    });

    on<ClearPinPressed>((event, emit) {
      emit(LoginState(pin: '', pinColors: List.filled(4, primaryAccentColor)));
    });
  }

  void _validatePin(String pin, Emitter<LoginState> emit) {
    // Dummy validation, replace with actual validation logic
    final isValid = pin == '1234';
    final newPinColors = List.filled(4, isValid ? secondaryColor : errorColor);
    emit(LoginState(pin: pin, pinColors: newPinColors));
  }
}
