import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movie_get_discover_provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('SMovie App')),
      body: Consumer<MovieGetDiscoverProvider>(builder: (_, provider, __) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.movies.isNotEmpty) {
          return ListView.builder(
            itemCount: provider.movies.length,
            itemBuilder: (context, index) {
            final movie = provider.movies[index];
            return ListTile(
              title: Text(movie.title),
              subtitle: Text(movie.overview),
            );
          });
        }

        return const Center(
          child: Text('No movies found'),
        );
      }),
    );
  }
}
