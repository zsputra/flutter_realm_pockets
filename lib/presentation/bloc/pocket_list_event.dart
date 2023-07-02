part of 'pocket_list_bloc.dart';

@immutable
abstract class PocketListEvent {}

class LoadPocketListEvent extends PocketListEvent{
  final Realm pocketRealm;

  LoadPocketListEvent(this.pocketRealm);
  
}
