// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Gallery {
  final String groupId;
  final List<String> photoUrl;
  final DateTime createdAt;
  final String photoID;
  Gallery({
    required this.groupId,
    required this.photoUrl,
    required this.createdAt,
    required this.photoID,
  });

  Gallery copyWith({
    String? groupId,
    List<String>? photoUrl,
    DateTime? createdAt,
    String? photoID,
  }) {
    return Gallery(
      groupId: groupId ?? this.groupId,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      photoID: photoID ?? this.photoID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groupId': groupId,
      'photoUrl': photoUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'photoID': photoID,
    };
  }

  factory Gallery.fromMap(Map<String, dynamic> map) {
    return Gallery(
      groupId: map['groupId'] ?? '',
      photoUrl: List<String>.from(map['photoUrl']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      photoID: map['photoID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Gallery.fromJson(String source) =>
      Gallery.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Photo(groupId: $groupId, photoUrl: $photoUrl, createdAt: $createdAt, photoID: $photoID)';
  }

  @override
  bool operator ==(covariant Gallery other) {
    if (identical(this, other)) return true;

    return other.groupId == groupId &&
        listEquals(other.photoUrl, photoUrl) &&
        other.createdAt == createdAt &&
        other.photoID == photoID;
  }

  @override
  int get hashCode {
    return groupId.hashCode ^
        photoUrl.hashCode ^
        createdAt.hashCode ^
        photoID.hashCode;
  }
}
