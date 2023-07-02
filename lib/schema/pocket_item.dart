import 'package:realm/realm.dart';

part 'pocket_item.g.dart';

@RealmModel()
class _PocketItem {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  late String? pocketName;

  late String? emoji;
}
