import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_themoviedb/commons/utils/navigator.dart';
import 'package:flutter_themoviedb/constants/end_points.dart';
import 'package:flutter_themoviedb/data/models/movie.dart';
import 'package:flutter_themoviedb/presentation/base/base_state.dart';
import 'package:flutter_themoviedb/presentation/movie_detail/movie_detail_page.dart';
import 'package:flutter_themoviedb/presentation/movie_list/movie_list_bloc.dart';
import 'package:flutter_themoviedb/presentation/widgets/rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class MovieListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GetIt.instance.get<MovieListBloc>();
      },
      child: MovieListForm(),
    );
  }
}

class MovieListForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MovieListFormState();
  }
}

class _MovieListFormState extends BaseStatefulState<MovieListForm> {
  List<Movie> movies = [];
  List<Movie> allMovies = [];

  bool filtering = false;

  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<MovieListBloc>(context).add(GetMovieEvent());
  }

  @override
  void dispose() {
    timeHandle?.cancel();
    super.dispose();
  }

  Timer? timeHandle;

  void textChanged(String value) {
    if (timeHandle != null) {
      timeHandle?.cancel();
    }
    timeHandle = Timer(Duration(seconds: 1), () {
      _onFilter();
    });
  }

  _onFilter() {
    final start = int.tryParse(_fromController.text) ?? 0;
    final end = int.tryParse(_toController.text) ?? 0;
    print('filtering: $start - $end');
    if (start > end) {
      setState(() {
        movies = [];
      });
      return;
    }

    setState(() {
      movies = allMovies.where((element) => (element.releaseYear ?? 0) >= start && (element.releaseYear ?? 0) <= end).toList();
    });
  }

  _clearFilter() {
    _fromController.text = '';
    _toController.text = '';
    setState(() {
      movies = allMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieListBloc, MovieListState>(
      listener: (context, state) {
        if (state is MovieListGetFailed) {
          dismissLoadingDialog(context);
        }

        if (state is MovieListLoading) {
          showLoadingDialog(context);
        }

        if (state is MovieListGetSuccess) {
          dismissLoadingDialog(context);
          allMovies = state.movies;
          setState(() {
            movies = state.movies;
          });
        }
      },
      child: BlocBuilder<MovieListBloc, MovieListState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Top Rated Movies'),
              actions: [
                IconButton(onPressed: () {
                  setState(() {
                    filtering = !filtering;
                  });
                  if (!filtering) _clearFilter();
                }
                , icon: Icon(filtering ? Icons.close : Icons.filter_list))
              ],
            ),
            body: Container(
              color: Colors.white,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  if (filtering)
                    _filterView(),
                  Expanded(child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return _itemView(movies[index]);
                      }))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _filterView() {
    return Column(
      children: [
        SizedBox(height: 8,),
        Text('Select release date range:', style: TextStyle(fontSize: 16),),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Form(
                autovalidate: true,
                child: SizedBox(
                  width: 140,
                  child: TextFormField(
                    controller: _fromController,
                    keyboardType: TextInputType.number,
                    onChanged: textChanged,
                    decoration: InputDecoration(
                        labelText: "From",
                        labelStyle: TextStyle(
                            color: Colors.lightGreen
                        ),
                        errorStyle: TextStyle(
                            color: Colors.red
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                    validator: (value){
                      final year = int.tryParse(value ?? '0');
                      if (year == null || year > DateTime.now().year) {
                        return "Enter correct year";
                      }
                    },
                  ),
                ),
              ),
              Form(
                autovalidate: true,
                child: SizedBox(
                  width: 140,
                  child: TextFormField(
                    controller: _toController,
                    keyboardType: TextInputType.number,
                    onChanged: textChanged,
                    decoration: InputDecoration(
                        labelText: "To",
                        labelStyle: TextStyle(
                            color: Colors.lightGreen
                        ),
                        errorStyle: TextStyle(
                            color: Colors.red
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                    validator: (value){
                      final year = int.tryParse(value ?? '0');
                      if (year == null || year > DateTime.now().year) {
                        return "Enter correct year";
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 12,)
      ],
    );
  }

  Widget _itemView(Movie movie) {
    return GestureDetector(
      onTap: () {
        final page = MovieDetailView(Key(movie.id.toString()), movie: movie);
        pushTo(context, page);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(ApiUrls.image(movie.posterPath)),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title ?? '',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 8,),
                Text(
                  movie.releaseDate ?? '',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    StaticRatingBar(movie.voteAverage ?? 0),
                    SizedBox(width: 4,),
                    Text('(${movie.voteCount})')
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
