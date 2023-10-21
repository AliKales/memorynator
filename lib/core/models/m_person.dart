import 'package:caroby/caroby.dart';
import 'package:memorynator/core/extensions/ext_date_time.dart';

class MPerson {
  String id;
  String? name;
  String? randomAvatarText;
  String? imagePath;
  DateTime createdAt;

  MPerson({
    required this.id,
    this.name,
    this.randomAvatarText,
    required this.createdAt,
    this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'randomAvatarText': randomAvatarText,
      'imagePath': imagePath,
      'createdAt': createdAt.toSql,
    };
  }

  factory MPerson.fromJson(Map<String, dynamic> json) {
    return MPerson(
      id: json['id'] as String,
      name: json['name'] as String?,
      randomAvatarText: json['randomAvatarText'] as String?,
      imagePath: json['imagePath'] as String?,
      createdAt: (json['createdAt'] as int).millisecsToDate(true),
    );
  }
}
