import 'package:equatable/equatable.dart';

abstract class AuthCubitState extends Equatable {
  const AuthCubitState();

  @override
  List<Object?> get props => [];
}

class InitState extends AuthCubitState {}

class AuthenticatingState extends AuthCubitState {}

/// Не добавляю ошибку в props, чтобы в случае, если 2 раза подряд пришла одна и та же ошибка, снэкбар отобразился

class AuthenticationErrorState extends AuthCubitState {
  final String message;
  const AuthenticationErrorState(this.message);
}

class AuthenticatedState extends AuthCubitState {}
