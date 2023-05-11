import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/news/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants.dart';

class NewsCard extends ConsumerStatefulWidget {
  final Article article;
  const NewsCard({Key? key, required this.article}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsCardState();
}

class _NewsCardState extends ConsumerState<NewsCard> {

    double selectedWidthActive = 0;
  double selectedHeightActive = 0;
  
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double selectedWidthInActive = width * 0.40;
    double selectedHeightInActive = height * 0.20;


    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      height: selectedHeightInActive,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: InkWell(
        splashColor: Colors.grey, // Splash color
        onTap: () async {
        },
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.article.image == null
                          ? ApiUrls.imageNotFound
                          : widget.article.image.toString(),
                      errorWidget: (context, string, _) {
                        return const Icon(Icons.error);
                      },
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.article.title.toString(),
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600 ,fontSize: 19),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
