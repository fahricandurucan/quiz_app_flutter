import 'package:hive_flutter/hive_flutter.dart';

part 'category.g.dart';

@HiveType(typeId: 0)
class Category {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(id: map["id"], name: map["name"]);
  }

  @override
  String toString() {
    return "$id - $name";
  }
}
