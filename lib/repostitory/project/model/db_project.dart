
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class DBProject extends HiveObject {

  @HiveField(0)
  DateTime startDate;

  @HiveField(1)
  DateTime endDate;
}