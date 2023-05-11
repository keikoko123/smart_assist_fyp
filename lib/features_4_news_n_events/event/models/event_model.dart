// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';




class EventModel {
  String name;
  String date;
  String time;
  EventModel({
    required this.name,
    required this.date,
    required this.time,
  });
  

  EventModel copyWith({
    String? name,
    String? date,
    String? time,
  }) {
    return EventModel(
      name: name ?? this.name,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'date': date,
      'time': time,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      name: map['name'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) => EventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EventModel(name: $name, date: $date, time: $time)';

  @override
  bool operator ==(covariant EventModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.date == date &&
      other.time == time;
  }

  @override
  int get hashCode => name.hashCode ^ date.hashCode ^ time.hashCode;
}
