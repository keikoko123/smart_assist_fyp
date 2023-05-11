import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/event/providers/event_provider.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/events_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends ConsumerStatefulWidget {
  const Calendar({super.key});
  static const String routeName = '/calendar';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarState();
}


List<String> colors = <String>[
  'Pink',
  'Blue',
  'Wall Brown',
  'Yellow',
  'Default'
];


class _CalendarState extends ConsumerState<Calendar> {


  String? _subjectText = '',
      _startTimeText = '',
      _endTimeText = '',
      _dateText = '',
      _timeDetails = '';
  Color? _headerColor, _viewHeaderColor, _calendarColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: const Icon(Icons.color_lens),
              itemBuilder: (BuildContext context) {
                return colors.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              onSelected: (String value) {
                setState(() {
                  if (value == 'Pink') {
                    _headerColor = const Color(0xFF09e8189);
                    _viewHeaderColor = const Color(0xFF0f3acb6);
                    _calendarColor = const Color(0xFF0ffe5d8);
                  } else if (value == 'Blue') {
                    _headerColor = const Color(0xFF0007eff);
                    _viewHeaderColor = const Color(0xFF03aa4f6);
                    _calendarColor = const Color(0xFF0bae5ff);
                  } else if (value == 'Wall Brown') {
                    _headerColor = const Color(0xFF0937c5d);
                    _viewHeaderColor = const Color(0xFF0e6d9b1);
                    _calendarColor = const Color(0xFF0d1d2d6);
                  } else if (value == 'Yellow') {
                    _headerColor = const Color(0xFF0f7ed53);
                    _viewHeaderColor = const Color(0xFF0fff77f);
                    _calendarColor = const Color(0xFF0f7f2cc);
                  } else if (value == 'Default') {
                    _headerColor = null;
                    _viewHeaderColor = null;
                    _calendarColor = null;
                  }
                });
              },
            ),
          ],
          backgroundColor: _headerColor,
        ),
        body: SafeArea(
          child: SfCalendar(
            viewHeaderStyle: ViewHeaderStyle(backgroundColor: _viewHeaderColor),
            backgroundColor: _calendarColor,
            view: CalendarView.month,
            allowedViews: const [
              CalendarView.day,
              CalendarView.week,
              CalendarView.workWeek,
              CalendarView.month,
              CalendarView.timelineDay,
              CalendarView.timelineWeek,
              CalendarView.timelineWorkWeek,
            ],
            monthViewSettings: const MonthViewSettings(showAgenda: true),
            dataSource: getCalendarDataSource(), //! events_notifierProvider1
            onTap: calendarTapped,
          ),
        ));
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Appointment appointmentDetails = details.appointments![0];
      _subjectText = appointmentDetails.subject;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.startTime)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      if (appointmentDetails.isAllDay) {
        _timeDetails = 'All day';
      } else {
        _timeDetails = '$_startTimeText - $_endTimeText';
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Container(child: Text('$_subjectText')),
              content: Container(
                height: 80,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '$_dateText',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: const <Widget>[
                        Text(''),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(_timeDetails!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15)),
                      ],
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('close'))
              ],
            );
          });
    }
  }

  _DataSource getCalendarDataSource() {

    return _DataSource( ref.watch(events_notifierProvider0));
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}
