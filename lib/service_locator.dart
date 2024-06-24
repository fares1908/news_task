import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'core/classes/network_info.dart';
import 'features/news/data/data_sources/news_local_data_source.dart';
import 'features/news/data/data_sources/news_remote_data_source.dart';
import 'features/news/data/repositories/news_repository_impl.dart';
import 'features/news/domain/repositories/news_repository.dart';
import 'features/news/domain/use_cases/get_news_articles.dart';
import 'features/news/data/models/news_article_model.dart';


final di = GetIt.instance;

Future<void> init() async {
  // Initialize Hive and open a box
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(NewsArticleModelAdapter());
  }
  final newsBox = await Hive.openBox<NewsArticleModel>('news');

  // Register NetworkInfo
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));

  // Register Local Data Source
  di.registerLazySingleton<NewsLocalDataSource>(
        () => NewsLocalDataSourceImpl(box: newsBox),
  );

  // Register Remote Data Source
  di.registerLazySingleton<NewsRemoteDataSource>(
        () => NewsRemoteDataSourceImpl(),
  );

  // Register Repository
  di.registerLazySingleton<NewsRepository>(
        () => NewsRepositoryImpl(
      remoteDataSource: di(),
      localDataSource: di(),
      networkInfo: di(),
    ),
  );

  // Register Use Case
  di.registerLazySingleton(() => GetNewsArticlesUseCase(di()));
}
