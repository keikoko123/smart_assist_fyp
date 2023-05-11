import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/common/utils/colors.dart';
import 'package:smart_assist_fyp/common/widgets/loader.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/gallery/controller/gallery_controller.dart';
import 'package:smart_assist_fyp/models_area3/photo_model.dart';
import 'package:smart_assist_fyp/models_area3/status_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import 'package:smart_assist_fyp/features_3_chat_n_gallery/gallery/src/animated_grid_to_list.dart';

class GalleryScreen extends ConsumerStatefulWidget {
  static const String routeName = '/status-screen';

  const GalleryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {
  late AnimatedGridToListController controller;
  @override
  void initState() {
    super.initState();
    setState(() {});
    controller = AnimatedGridToListController(); //! 個lifecycle會 比較準確d
    ref.read(controller_galleryRepositoryProvider).getGallery(context);
   // ref.read(controller_galleryRepositoryProvider);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;



    return FutureBuilder<List<String>>(
      future:
          ref.read(controller_galleryRepositoryProvider).getGallery(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        return AnimatedGridToList(
            controller: controller,
            onTap: (i) {
              if (!controller.isExpanded) {
                controller.expand(i, const Duration(seconds: 1));
              } else {
                controller.shrink(const Duration(seconds: 0));
              }
            },
            itemBuilder: AnimatedGridToListItemBuilder(
              wrapAlignment: WrapAlignment.start,
              animatedItemBuilder: (context, index) => Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.8,
              //  color: containers[index].color,
                padding: const EdgeInsets.all(8),
                child: Image.network(snapshot.data![index]),
              ),
              gridItemBuilder: (context, index) {
                return Image.network(snapshot.data![index],fit: BoxFit.fill);
              },
              listItemBuilder: (context, index) => Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width ,
               // color: containers[index].color,
                padding: const EdgeInsets.all(8),
                child: Image.network(snapshot.data![index],fit: BoxFit.fitWidth),
              ),
              listItemSize: Size(
                MediaQuery.of(context).size.width ,
                MediaQuery.of(context).size.height * 0.6,
              ),
              gridItemSize:  Size(width/3 , width/3),
              itemCount: snapshot.data!.length,
            ));
      },
    );
  }
}
