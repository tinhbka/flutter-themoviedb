
const String BASE_URL = 'api.themoviedb.org';

class ApiUrls {
  static const String topRatedMovies = '/3/movie/top_rated';
  static Function tvVideos           = (int id)             => '/3/movie/$id/videos';
  static Function image              = (String path)        => 'https://image.tmdb.org/t/p/w500/$path';
  static Function videoThumbnail     = (String key)         => 'https://img.youtube.com/vi/$key/0.jpg';
}