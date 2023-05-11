import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';





final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepository();
});



class EventRepository {
  List<Appointment> events_notifierProvider1_HK() {
    final List<Appointment> appointments = <Appointment>[];
    //! 1
    appointments.add(Appointment(
      startTime: DateTime(2023, 4, 27, 12, 0),
      endTime: DateTime(2023, 4, 27, 16, 0),
      subject: '長者中國舞訓練班 - 柴灣體育館',
      color: Colors.lightBlueAccent,
    ));

    //! 2
    appointments.add(Appointment(
      startTime: DateTime(2023, 4, 28, 9, 0),
      endTime: DateTime(2023, 4, 28, 11, 0),
      subject: '長者普及體操同樂日 - 港灣道體育館 ',
      color: Colors.amber,
    ));

    //! 3
    appointments.add(Appointment(
      startTime: DateTime(2023, 4, 30, 15, 0),
      endTime: DateTime(2023, 4, 30, 17, 0),
      subject: '長者游泳訓練班 - 堅尼地城游泳池',
      color: Colors.green,
    ));

    //! 4
    appointments.add(Appointment(
      startTime: DateTime(2023, 4, 30, 18, 0),
      endTime: DateTime(2023, 4, 30, 20, 0),
      subject: '活力長者-美式桌球同樂 - 鴨脷洲體育館',
      color: Colors.purple,
    ));

    return appointments;
  }

  List<Appointment> events_notifierProvider2_KL() {
    final List<Appointment> appointments = <Appointment>[];
    //! 1
    appointments.add(Appointment(
      startTime: DateTime(2023, 4, 27, 12, 0),
      endTime: DateTime(2023, 4, 27, 16, 0),
      subject: '長者中國舞訓練班 - 九龍塘體育館',
      color: Colors.lightBlueAccent,
    ));

    //! 2
    appointments.add(Appointment(
      startTime: DateTime(2023, 4, 29, 9, 0),
      endTime: DateTime(2023, 4, 29, 11, 0),
      subject: '長者普及體操同樂日 - 深水埗體育館 ',
      color: Colors.amber,
    ));

    //! 3
    appointments.add(Appointment(
      startTime: DateTime(2023, 4, 29, 15, 0),
      endTime: DateTime(2023, 4, 29, 17, 0),
      subject: '長者游泳訓練班 -長沙灣游泳池',
      color: Colors.green,
    ));

    //! 4
    appointments.add(Appointment(
      startTime: DateTime(2023, 4, 30, 11, 0),
      endTime: DateTime(2023, 4, 30, 14, 0),
      subject: '活力長者-美式桌球同樂 - 葵芳體育館',
      color: Colors.purple,
    ));

    return appointments;
  }

  List<Appointment> events_notifierProvider3_NT() {
    final List<Appointment> appointments = <Appointment>[];
    //! 1
    appointments.add(Appointment(
      startTime: DateTime(2023, 4, 27, 12, 0),
      endTime: DateTime(2023, 4, 27, 16, 0),
      subject: '長者中國舞訓練班 - 屯門體育館',
      color: Colors.lightBlueAccent,
    ));

    //! 2
    appointments.add(Appointment(
      startTime: DateTime(2023, 4, 28, 9, 0),
      endTime: DateTime(2023, 4, 28, 11, 0),
      subject: '長者普及體操同樂日 - 天水圍體育館 ',
      color: Colors.amber,
    ));

    //! 3
    appointments.add(Appointment(
      startTime: DateTime(2023, 4, 29, 15, 0),
      endTime: DateTime(2023, 4, 29, 17, 0),
      subject: '長者游泳訓練班 -  城門游泳池',
      color: Colors.green,
    ));

    //! 4
    appointments.add(Appointment(
      startTime: DateTime(2023, 4, 30, 11, 0),
      endTime: DateTime(2023, 4, 30, 14, 0),
      subject: '活力長者-美式桌球同樂 - 荃灣體育館',
      color: Colors.purple,
    ));

    return appointments;
  }
}

//!　Hong Kong    Kowloon 　　　New Territories

//! 九龍 新界 港島
final events_notifierProvider2 = Provider<List<Appointment>>((ref) {
  final List<Appointment> appointments = <Appointment>[];
  //! 1
  appointments.add(Appointment(
    startTime: DateTime(2023, 4, 27, 12, 0),
    endTime: DateTime(2023, 4, 27, 16, 0),
    subject: '行山',
    color: Colors.lightBlueAccent,
  ));

  //! 2
  appointments.add(Appointment(
    startTime: DateTime(2023, 4, 27, 12, 0),
    endTime: DateTime(2023, 4, 27, 16, 0),
    subject: '箭藝同樂日',
    color: Colors.amber,
  ));

  //! 3
  appointments.add(Appointment(
    startTime: DateTime(2023, 4, 27, 12, 0),
    endTime: DateTime(2023, 4, 27, 16, 0),
    subject: '活力長者計劃 - 乒乓球同樂',
    color: Colors.green,
  ));

  //! 4
  appointments.add(Appointment(
    startTime: DateTime(2023, 4, 27, 12, 0),
    endTime: DateTime(2023, 4, 27, 16, 0),
    subject: '長者康體匯敘 - 社交舞',
    color: Colors.purple,
  ));

  return appointments;
});

final events_notifierProvider3 = Provider<List<Appointment>>((ref) {
  final List<Appointment> appointments = <Appointment>[];
  //! 1
  appointments.add(Appointment(
    startTime: DateTime(2023, 4, 27, 12, 0),
    endTime: DateTime(2023, 4, 27, 16, 0),
    subject: '行山',
    color: Colors.lightBlueAccent,
  ));

  //! 2
  appointments.add(Appointment(
    startTime: DateTime(2023, 4, 27, 12, 0),
    endTime: DateTime(2023, 4, 27, 16, 0),
    subject: '箭藝同樂日',
    color: Colors.amber,
  ));

  //! 3
  appointments.add(Appointment(
    startTime: DateTime(2023, 4, 27, 12, 0),
    endTime: DateTime(2023, 4, 27, 16, 0),
    subject: '活力長者計劃 - 乒乓球同樂',
    color: Colors.green,
  ));

  //! 4
  appointments.add(Appointment(
    startTime: DateTime(2023, 4, 27, 12, 0),
    endTime: DateTime(2023, 4, 27, 16, 0),
    subject: '長者康體匯敘 - 社交舞',
    color: Colors.purple,
  ));

  return appointments;
});

final events_notifierProvider4 = Provider<List<Appointment>>((ref) {
  final List<Appointment> appointments = <Appointment>[];
  //! 1
  appointments.add(Appointment(
    startTime: DateTime(2023, 4, 27, 12, 0),
    endTime: DateTime(2023, 4, 27, 16, 0),
    subject: '行山',
    color: Colors.lightBlueAccent,
  ));

  //! 2
  appointments.add(Appointment(
    startTime: DateTime(2023, 4, 27, 12, 0),
    endTime: DateTime(2023, 4, 27, 16, 0),
    subject: '箭藝同樂日',
    color: Colors.amber,
  ));

  //! 3
  appointments.add(Appointment(
    startTime: DateTime(2023, 4, 27, 12, 0),
    endTime: DateTime(2023, 4, 27, 16, 0),
    subject: '活力長者計劃 - 乒乓球同樂',
    color: Colors.green,
  ));

  //! 4
  appointments.add(Appointment(
    startTime: DateTime(2023, 4, 27, 12, 0),
    endTime: DateTime(2023, 4, 27, 16, 0),
    subject: '長者康體匯敘 - 社交舞',
    color: Colors.purple,
  ));

  return appointments;
});
//!  新界
final events_notifierProvider0 =
    NotifierProvider<NT_Events_Notifier, List<Appointment>>(
        NT_Events_Notifier.new);

// final events_notifierProvider2 = NotifierProvider<Events_Notifier, List<Appointment>>(Events_Notifier.new);
class NT_Events_Notifier extends Notifier<List<Appointment>> {
  void addTodo(Appointment event) {
    state = [...state, event];
  }

  @override
  build() {
    final List<Appointment> appointments = <Appointment>[];
    return appointments;
  }
}
