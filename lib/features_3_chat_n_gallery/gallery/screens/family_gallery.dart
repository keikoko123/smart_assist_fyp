import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/common/widgets/loader.dart';
import 'package:smart_assist_fyp/models_area3/status_model.dart';
import 'package:story_view/story_view.dart';


class Family_Gallery extends ConsumerStatefulWidget {
  const Family_Gallery({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Family_GalleryState();
}

class _Family_GalleryState extends ConsumerState<Family_Gallery> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('This iss family gallery'),
    );
  }
}


class StatusScreen extends StatefulWidget {
  static const String routeName = '/status-screen';
  final Status status;
  const StatusScreen({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  StoryController controller = StoryController();
  List<StoryItem> storyItems = [];

  @override
  void initState() {
    super.initState();
    initStoryPageItems();
  }

  void initStoryPageItems() {
    for (int i = 0; i < widget.status.photoUrl.length; i++) {
      storyItems.add(StoryItem.pageImage(
        url: widget.status.photoUrl[i],
        controller: controller,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: storyItems.isEmpty
          ? const Loader()
          : StoryView(
              storyItems: storyItems,
              controller: controller,
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.pop(context);
                }
              },
            ),
    );
  }
}
