import 'package:flutter/material.dart';
import 'package:simple_movies_app/movie/models/movie_model.dart';
import 'package:simple_movies_app/movie/repositories/movie_repository.dart';

class MovieGetDiscoverProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetDiscoverProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void getDiscover(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    final result = await _movieRepository.getDiscover();

    result.fold((errorMessage) {
      debugPrint(errorMessage);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
      _isLoading = false;
      notifyListeners();
      return;
    }, (response) {
      _movies.clear();
      _movies.addAll(response.results);
      _isLoading = false;
      notifyListeners();
      return;
    });
  }
}
