import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/news/providers/news_provider.dart';

class SearchField extends ConsumerStatefulWidget {
  const SearchField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField>
    with TickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: 5, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
                          ref.read(newsProvider.notifier).loadSearchedNews2( _controller.index.toString());
        
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Debouncer _debouncer = Debouncer();
    return Column(
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
              _debouncer.run(() {
                if (value.isNotEmpty) {
                  ref.read(newsProvider.notifier).loadSearchedNews(value);
                } else {
                  ref.read(newsProvider.notifier).loadNews();
                }
              });
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(15),
                hintText: 'Search News',
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

          length: 5,
          child: TabBar(
            
          controller: _controller,
            
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Creates border
                color: Colors.orange),
            labelStyle: TextStyle(fontSize: 14.5),
            isScrollable: true,
//!　Hong Kong    Kowloon 　　　New Territories

            tabs: const [
              Tab(
                text: "Healthy",
              ),
              Tab(
                text: "Sick",
              ),
              Tab(
                text: "Food",
              ),
              Tab(
                text: "Leisure",
              ),
              Tab(
                text: "Culture",
              ),

            ],
          ),
        ),
      ],
    );
  }
}






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
