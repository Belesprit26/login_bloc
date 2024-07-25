import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PinDigitPressed extends LoginEvent {
  final String digit;

  const PinDigitPressed(this.digit);

  @override
  List<Object> get props => [digit];
}

class ClearPinPressed extends LoginEvent {}
