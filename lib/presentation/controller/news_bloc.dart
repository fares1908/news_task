import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_news_app/domain/entities/news_article.dart';
import 'package:task_news_app/domain/use_cases/get_news_articles.dart';
import 'package:task_news_app/core/error/failure.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsArticles getNewsArticles;

  NewsBloc({required this.getNewsArticles}) : super(NewsInitial()) {
    on<GetNews>(_onGetNews);
  }

  void _onGetNews(GetNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await getNewsArticles();
    result.fold(
          (failure) => emit(NewsError(failure.message)),
          (news) => emit(NewsLoaded(news)),
    );
  }
}
