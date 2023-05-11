import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:smart_assist_fyp/common/utils/utils.dart';
import 'package:smart_assist_fyp/features_0_common/auth/controller/auth_controller.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/colors.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/select_contacts/screens/select_contacts_screen.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/widgets/contacts_list.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/common/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/common/widgets/loader.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/event/providers/event_provider.dart';
import 'package:smart_assist_fyp/models_area3/status_model.dart';
import 'package:story_view/story_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/news/models/news_model.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/news/providers/news_provider.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/news/widgets/news_card.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/news/widgets/search_field.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:async';
import 'package:smart_assist_fyp/features_4_news_n_events/event/widgets/search_field2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/news/providers/news_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

//todo https://data.gov.hk/tc-data/dataset/hk-lcsd-event-event-leisure/resource/ecc6c632-2905-4f6b-934d-39d284bdc3fe

class Debouncer {
  final int milliseconds;

  Timer? _timer;

  Debouncer({this.milliseconds = 500});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class EventPage extends ConsumerStatefulWidget {
  const EventPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventPageState();
}

class _EventPageState extends ConsumerState<EventPage>
    with TickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Debouncer _debouncer = Debouncer();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double selectedWidthInActive = width * 0.40;
    double selectedHeightInActive = height * 0.20;

    List<Appointment> appointments =
        ref.read(eventRepositoryProvider).events_notifierProvider1_HK();

    if (_selectedIndex.toString() == '0') {
      appointments =
          ref.read(eventRepositoryProvider).events_notifierProvider1_HK();
    } else if (_selectedIndex.toString() == '1') {
      appointments =
          ref.read(eventRepositoryProvider).events_notifierProvider2_KL();
    } else if (_selectedIndex.toString() == '2') {
      appointments =
          ref.read(eventRepositoryProvider).events_notifierProvider3_NT();
    }

    //! TTS FUNCTION
    return SafeArea(
      child: Column(children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: const Color(0xff1D1617).withOpacity(0.11),
                    blurRadius: 40,
                    spreadRadius: 0.0)
              ]),
              child: TextField(
                onChanged: (value) {
                  // _debouncer.run(() {
                  //   if (value.isNotEmpty) {
                  //     ref.read(newsProvider.notifier).loadSearchedNews(value);
                  //   } else {
                  //     ref.read(newsProvider.notifier).loadNews();
                  //   }
                  // });
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(15),
                    hintText: 'Search Events',
                    hintStyle:
                        const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none)),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            DefaultTabController(
              length: 3,
              child: TabBar(
                controller: _controller,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Creates border
                    color: Colors.orange),
                labelStyle: TextStyle(fontSize: 16),
                isScrollable: true,
                tabs: const [
                  Tab(
                    text: "Hong Kong ",
                  ),
                  Tab(
                    text: "Kowloon",
                  ),
                  Tab(
                    text: "New Territories",
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: appointments.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              //return Text(appointments[index].subject);

              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                height: selectedHeightInActive,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange[100]),
                child: InkWell(
                  splashColor: Colors.grey, // Splash color
                  onTap: () {
                    ref.read(events_notifierProvider0).add(appointments[index]);
                    debugPrint("event added");
                    MotionToast.success(
                      title: Text("Success Join the Event"),
                      description: Text("Pls Check Your Calendar!"),
                    ).show(context);
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    appointments[index].subject,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    DateFormat('MMMM dd, yyyy')
                                        .format(appointments[index].startTime),

//                              appointments[index].startTime.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    DateFormat('hh:mm a')
                                        .format(appointments[index].startTime),

//                              appointments[index].startTime.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    DateFormat('hh:mm a')
                                        .format(appointments[index].endTime),

//                              appointments[index].startTime.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
