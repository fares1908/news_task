
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/news_bloc.dart';
import '../controller/theme_bloc.dart';
import 'news_detail_page.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
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
            return const Center(child: CircularProgressIndicator());
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
            return const Center(child: Text('Failed to fetch news'));
          }
        },
      ),
    );
  }
}
