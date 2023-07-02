// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector_config.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureBloc() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => PocketListBloc())
      ..registerSingleton((c) => LoginBloc());
  }
}
