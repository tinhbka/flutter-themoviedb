import 'package:flutter_themoviedb/data/repository/movie_repository_impl.dart';
import 'package:flutter_themoviedb/domain/repository/movie_repository.dart';
import 'package:flutter_themoviedb/presentation/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_themoviedb/presentation/movie_list/movie_list_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerSingleton<MovieRepository>(MovieRepositoryImpl());
  getIt.registerSingleton<MovieListBloc>(
      MovieListBloc(movieRepository: getIt.get<MovieRepository>()));
}
