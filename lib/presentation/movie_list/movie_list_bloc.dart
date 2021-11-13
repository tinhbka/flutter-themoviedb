
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_themoviedb/data/models/movie.dart';
import 'package:flutter_themoviedb/domain/repository/movie_repository.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {

  final MovieRepository movieRepository;

  MovieListBloc({
    required this.movieRepository,
  }) : super(MovieListInitial());

  MovieListState get initialState => MovieListInitial();

  @override
  Stream<MovieListState> mapEventToState(
      MovieListEvent event,
      ) async* {
    if (event is GetMovieEvent) {
      yield MovieListLoading();

      try {
        final response = await movieRepository.getMovies();

        if (response.data != null) {
          yield MovieListGetSuccess(response.data!);
        } else {
          yield MovieListGetFailed(error: 'Unknow Error');
        }
      } catch (error) {
        yield MovieListGetFailed(error: error.toString());
      }
    }

  }
}

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();
}

class GetMovieEvent extends MovieListEvent {
  @override
  List<Object> get props => [];
}

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListInitial extends MovieListState {}
class MovieListLoading extends MovieListState {}

class MovieListGetSuccess extends MovieListState {
  final List<Movie> movies;

  MovieListGetSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieListGetFailed extends MovieListState {
  final String error;

  const MovieListGetFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'MovieListGetFailed{error: $error}';
  }
}