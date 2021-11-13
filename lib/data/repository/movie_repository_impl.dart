
import 'package:flutter_themoviedb/constants/end_points.dart';
import 'package:flutter_themoviedb/constants/key.dart';
import 'package:flutter_themoviedb/data/models/movie.dart';
import 'package:flutter_themoviedb/data/models/video.dart';
import 'package:flutter_themoviedb/data/remote/network_utils.dart';
import 'package:flutter_themoviedb/domain/repository/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  @override
  Future<MovieResponse> getMovies() async {
    final queryParameters = {
      'api_key': Key.tmdbKey,
    };
    final url = Uri.https(
      BASE_URL,
      ApiUrls.topRatedMovies,
      queryParameters
    );
    print(url.toString());
    final json = await NetworkUtils.get(url);
    return MovieResponse.fromJson(json);
  }

  @override
  Future<VideoResponse> getVideo(int movieId) async {
    final queryParameters = {
      'api_key': Key.tmdbKey,
    };
    final url = Uri.https(
      BASE_URL,
      ApiUrls.tvVideos(movieId),
      queryParameters
    );
    final json = await NetworkUtils.get(url);
    return VideoResponse.fromJson(json);
  }

}