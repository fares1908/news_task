import 'package:get_it/get_it.dart';
import 'features/news/data/data_sources/news_remote_data_source.dart';
import 'features/news/data/repositories/news_repository_impl.dart';
import 'features/news/domain/repositories/news_repository.dart';
import 'features/news/domain/use_cases/get_news_articles.dart';

final di = GetIt.instance;

void init() {

  di.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(),
  );


  di.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(remoteDataSource: di()),
  );


  di.registerLazySingleton(() => GetNewsArticlesUseCase(di()));
}
