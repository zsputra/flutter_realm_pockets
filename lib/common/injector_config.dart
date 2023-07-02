import 'package:kiwi/kiwi.dart';
import 'package:pockets_app/presentation/bloc/pocket_list_bloc.dart';
import 'package:pockets_app/presentation/login/bloc/login_bloc.dart';

part 'injector_config.g.dart';

abstract class Injector {
  static KiwiContainer? container;

  static void setup() {
    container = KiwiContainer();
    _$Injector()._configure();
  }

  // For use from classes trying to get top-level
  // dependencies such as ChangeNotifiers or BLoCs
  static final resolve = container?.resolve;

  // ignore: unused_element
  void _configure() {
    _configureBloc();
  }

  @Register.singleton(PocketListBloc)
  @Register.singleton(LoginBloc)
  void _configureBloc();
}
