
import 'package:flutter_themoviedb/data/models/movie.dart';
import 'package:flutter_themoviedb/data/models/video.dart';

abstract class MovieRepository {
  Future<MovieResponse> getMovies();
  Future<VideoResponse> getVideo(int movieId);
}