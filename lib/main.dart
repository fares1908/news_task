import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/news/data/models/news_article_model.dart';
import 'features/news/domain/use_cases/get_news_articles.dart';
import 'features/news/presentation/controller/news_bloc.dart';
import 'features/news/presentation/controller/theme_bloc.dart';
import 'features/news/presentation/pages/news_list_page.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(NewsArticleModelAdapter());
  }
  await Hive.openBox<NewsArticleModel>('news');

  await di.init(); // Ensure DI is initialized before running the app

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsBloc(getNewsArticles: di.di<GetNewsArticlesUseCase>())..add(GetNews()),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Task News App',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeMode,
            home: const NewsListPage(),
          );
        },
      ),
    );
  }
}
