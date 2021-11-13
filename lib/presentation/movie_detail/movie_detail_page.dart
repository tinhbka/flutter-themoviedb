import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_themoviedb/commons/utils/navigator.dart';
import 'package:flutter_themoviedb/constants/end_points.dart';
import 'package:flutter_themoviedb/data/models/movie.dart';
import 'package:flutter_themoviedb/data/models/video.dart';
import 'package:flutter_themoviedb/domain/repository/movie_repository.dart';
import 'package:flutter_themoviedb/presentation/base/base_state.dart';
import 'package:flutter_themoviedb/presentation/widgets/common_alert.dart';
import 'package:flutter_themoviedb/presentation/widgets/rating_bar.dart';
import 'package:flutter_themoviedb/presentation/widgets/video_player.dart';
import 'package:get_it/get_it.dart';
import 'package:collection/collection.dart';

import 'movie_detail_bloc.dart';

class MovieDetailView extends StatelessWidget {
  final Movie movie;

  MovieDetailView(Key key, {required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title ?? ''),
      ),
      body: BlocProvider(
        create: (context) {
          return MovieDetailBloc(movieRepository: GetIt.instance.get<MovieRepository>());
        },
        child: MovieDetailForm(
          movie: movie,
        ),
      ),
    );
  }
}

class MovieDetailForm extends StatefulWidget {
  final Movie movie;

  MovieDetailForm({required this.movie});

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailFormState();
  }
}

class _MovieDetailFormState extends BaseStatefulState<MovieDetailForm> {

  Video? trailer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width * 9 / 16;
    return BlocListener<MovieDetailBloc, MovieDetailState>(
      listener: (context, state) {
        if (state is MovieDetailGetFailed) {
          dismissLoadingDialog(context);
        }

        if (state is MovieDetailLoading) {
          showLoadingDialog(context);
        }

        if (state is MovieDetailGetSuccess) {
          dismissLoadingDialog(context);
          Video? trailerVideo = state.movies.firstWhereOrNull((element) =>
              element.type == 'Trailer' && element.site == 'YouTube');
          if (trailerVideo != null) {
            trailer = trailerVideo;
            final page = VideoPlayerView(trailerVideo.key ?? '');
            presentTo(context, page);
          } else {
            showMessage(context, 'Sorry, Trailer not found!');
          }
        }
      },
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height,
                    child: Stack(
                      children: [
                        widget.movie.backdropPath == null
                            ? Container(
                                width: height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                      size: 50,
                                    ),
                                    Text(
                                      'Image not found',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      ApiUrls.image(widget.movie.backdropPath),
                                    ),
                                  ),
                                ),
                              ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              if (trailer != null) {
                                final page = VideoPlayerView(trailer?.key ?? '');
                                presentTo(context, page);
                                return;
                              }
                              BlocProvider.of<MovieDetailBloc>(context).add(
                                  GetMovieVideoEvent(widget.movie.id ?? 0));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                                right: 10,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Watch trailer',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.movie.title ??
                              '' + ' (${widget.movie.originalTitle ?? ''})',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              StaticRatingBar(widget.movie.voteAverage ?? 0),
                              SizedBox(width: 5),
                              Text(
                                widget.movie.voteAverage.toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.movie.overview ?? '',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
