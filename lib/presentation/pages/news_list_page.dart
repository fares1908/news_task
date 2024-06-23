// lib/presentation/pages/news_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_news_app/presentation/manager/news_bloc.dart';
import 'package:task_news_app/presentation/pages/news_detail_page.dart';

import '../manager/theme_bloc.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              final theme = Theme.of(context).brightness == Brightness.dark
                  ? ThemeData.light()
                  : ThemeData.dark();
              ThemeMode mode = theme == ThemeData.light() ? ThemeMode.light : ThemeMode.dark;
              context.read<ThemeCubit>().updateTheme(mode);
            },
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            return ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (context, index) {
                final article = state.news[index];
                return ListTile(
                  title: Text(article.title ?? 'No title'),
                  subtitle: Text(article.source ?? 'No source'),
                  leading: article.urlToImage != null && article.urlToImage!.isNotEmpty
                      ? Image.network(article.urlToImage!)
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(article: article),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('Failed to fetch news'));
          }
        },
      ),
    );
  }
}
