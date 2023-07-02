part of 'pocket_list_bloc.dart';

@immutable
abstract class PocketListState {}

class PocketListInitial extends PocketListState {}

class PocketListLoaded extends PocketListState {
  final RealmResults<PocketItem> pockets;

  PocketListLoaded(this.pockets);
}
