
import 'package:get_it/get_it.dart';

import 'package:task_news_app/data/data_sources/news_remote_data_source.dart';
import 'package:task_news_app/data/repositories/news_repository_impl.dart';

import 'package:task_news_app/domain/use_cases/get_news_articles.dart';

import 'domain/repositories/news_repository.dart';

final sl = GetIt.instance;

void init() {


  // Registering data source
  sl.registerLazySingleton<NewsRemoteDataSource>(
        () => NewsRemoteDataSourceImpl(),
  );

  // Registering repository
  sl.registerLazySingleton<NewsRepository>(
        () => NewsRepositoryImpl(remoteDataSource: sl()),
  );

  // Registering use cases
  sl.registerLazySingleton(() => GetNewsArticles(sl()));
}
