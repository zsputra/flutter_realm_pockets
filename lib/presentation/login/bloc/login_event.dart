part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class StartLogin extends LoginEvent{
   final App app;

  StartLogin(this.app);
   
}
