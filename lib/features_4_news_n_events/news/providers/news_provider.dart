import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/news/services/news_services.dart';

import '../models/news_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_provider.freezed.dart';

//! PAR
@freezed
class NewsState with _$NewsState {
  const factory NewsState({
    @Default(true) bool isLoading,
    required NewsModel newsModel,
  }) = _NewsState;

  const NewsState._();
}

class NewsNotifier extends StateNotifier<NewsState> {
  NewsNotifier() : super(NewsState(newsModel: NewsModel(articles: []))) {
    loadNews();
  }

  loadNews() async {
    state = state.copyWith(isLoading: true);
    final newsResponse = await NewsService().fetchNews();
    final news = NewsModel.fromJson(newsResponse);
    state = state.copyWith(newsModel: news, isLoading: false);
  }

  loadSearchedNews(String title) async {
    state = state.copyWith(isLoading: true);
    final newsResponse = await NewsService().fetchNewsBySearching(title);
    final news = NewsModel.fromJson(newsResponse);
    state = state.copyWith(newsModel: news, isLoading: false);
  }

  loadSearchedNews2(String title) async {
    state = state.copyWith(isLoading: true);
    final newsResponse = await NewsService().fetchNewsBySearching2(title);
    final news = NewsModel.fromJson(newsResponse);
    state = state.copyWith(newsModel: news, isLoading: false);
  }
}

final newsProvider =
    StateNotifierProvider<NewsNotifier, NewsState>((ref) => NewsNotifier());
