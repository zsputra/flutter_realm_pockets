part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  final Realm? realm;

  const LoginState({this.realm});

  @override
  List<Object?> get props => [realm];
}

class LoginInitial extends LoginState {}

class LoginSucceed extends LoginState {
  const LoginSucceed({required Realm realm}) : super(realm: realm);
}
