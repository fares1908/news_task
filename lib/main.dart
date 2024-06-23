import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_news_app/data/repositories/news_repository_impl.dart';
import 'package:task_news_app/domain/use_cases/get_news_articles.dart';
import 'package:task_news_app/presentation/manager/news_bloc.dart';
import 'package:task_news_app/presentation/manager/theme_bloc.dart';
import 'package:task_news_app/presentation/pages/news_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsRepository = NewsRepositoryImpl();
    final getNewsArticles = GetNewsArticles(newsRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsBloc(getNewsArticles: getNewsArticles)..add(GetNews()),
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
