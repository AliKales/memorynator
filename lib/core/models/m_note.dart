import 'package:caroby/caroby.dart';
import 'package:memorynator/core/extensions/ext_date_time.dart';
import 'package:memorynator/core/extensions/ext_list.dart';
import 'package:memorynator/core/extensions/ext_string.dart';
import 'package:memorynator/core/models/m_person.dart';

class MNote {
  final String id;
  final String personId;
  String? title;
  String? note;
  final DateTime createdAt;
  List<String>? images;
  String? audio;
  DateTime? reminder;

  MPerson? person;

  MNote({
    required this.id,
    required this.personId,
    this.title,
    this.note,
    required this.createdAt,
    this.images,
    this.audio,
    this.reminder,
    this.person,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'personId': personId,
      'title': title,
      'note': note,
      'createdAt': createdAt.toSql,
      'images': images.encode,
      'audio': audio,
      'reminder': reminder?.toSql,
    };
  }

  factory MNote.fromJson(Map<String, dynamic> json) {
    return MNote(
      id: json['id'] as String,
      personId: json['personId'] as String,
      title: json['title'] as String?,
      note: json['note'] as String?,
      createdAt: (json['createdAt'] as int).millisecsToDate(true),
      images: (json['images'] as String?).decodeList<String>(),
      audio: json['audio'] as String?,
      reminder: (json['reminder'] as int?)?.millisecsToDate(true),
    );
  }
}
