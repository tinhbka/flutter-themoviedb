import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_themoviedb/data/models/video.dart';
import 'package:flutter_themoviedb/domain/repository/movie_repository.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {

  final MovieRepository movieRepository;

  MovieDetailBloc({
    required this.movieRepository,
  }) : super(MovieDetailInitial());

  MovieDetailState get initialState => MovieDetailInitial();

  @override
  Stream<MovieDetailState> mapEventToState(
      MovieDetailEvent event,
      ) async* {
    if (event is GetMovieVideoEvent) {
      print('a');
      yield MovieDetailLoading();

      try {
        final response = await movieRepository.getVideo(event.movieId);

        if (response.data != null) {
          yield MovieDetailGetSuccess(response.data!);
        } else {
          yield MovieDetailGetFailed(error: 'Unknow Error');
        }
      } catch (error) {
        yield MovieDetailGetFailed(error: error.toString());
      }
    }

  }
}

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class GetMovieVideoEvent extends MovieDetailEvent {

  final int movieId;

  GetMovieVideoEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}
class MovieDetailLoading extends MovieDetailState {}

class MovieDetailGetSuccess extends MovieDetailState {
  final List<Video> movies;

  MovieDetailGetSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieDetailGetFailed extends MovieDetailState {
  final String error;

  const MovieDetailGetFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'MovieDetailGetFailed{error: $error}';
  }
}