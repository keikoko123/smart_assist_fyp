import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/news/models/news_model.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/news/providers/news_provider.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/news/widgets/news_card.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/news/widgets/search_field.dart';


class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {


  @override
  Widget build(BuildContext context) {
    NewsModel news = ref.watch(newsProvider).newsModel;
    bool isLoading = ref.watch(newsProvider).isLoading;
    //



    //! TTS FUNCTION
    return SafeArea(
      child: Column(children: [
        const SearchField(), //! the function would be into the mic floatting button


        isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: news.articles!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return NewsCard(article: news.articles![index]);
                  },
                ),
              )
      ]),
    );
  }
}
