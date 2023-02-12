import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:simple_movies_app/movie/models/movie_model.dart';
import 'movie_repository.dart';

class MovieRepositoryImplementation implements MovieRepository {
  final Dio _dio;

  MovieRepositoryImplementation(this._dio);

  @override
  Future<Either<String,MovieResponseModel>> getDiscover({int page = 1}) async {
    try {
      final result = await _dio.get('/discover/movie', queryParameters: {
        'page': page,
      });

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error getting discover movies');
    } on DioError catch (err) {
      if (err.response != null) {
        return const Left('Another error on get discover movies');
      }

      return Left(err.response.toString());
    }
  }
}
