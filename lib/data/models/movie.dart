import 'package:intl/intl.dart';

/// adult : false
/// backdrop_path : "/5hNcsnMkwU2LknLoru73c76el3z.jpg"
/// genre_ids : [35,18,10749]
/// id : 19404
/// original_language : "hi"
/// original_title : "दिलवाले दुल्हनिया ले जायेंगे"
/// overview : "Raj is a rich, carefree, happy-go-lucky second generation NRI. Simran is the daughter of Chaudhary Baldev Singh, who in spite of being an NRI is very strict about adherence to Indian values. Simran has left for India to be married to her childhood fiancé. Raj leaves for India with a mission at his hands, to claim his lady love under the noses of her whole family. Thus begins a saga."
/// popularity : 29.781
/// poster_path : "/2CAL2433ZeIihfX1Hb2139CX0pW.jpg"
/// release_date : "1995-10-20"
/// title : "Dilwale Dulhania Le Jayenge"
/// video : false
/// vote_average : 8.7
/// vote_count : 3214
///

class MovieResponse {
  List<Movie>? data;
  int? page;

  MovieResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> dataList = json['results'];
    page = json['page'];
    if (dataList != null) {
      data = dataList.map((e) => Movie.fromJson(e)).toList();
    }
  }
}

class Movie {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  int? get releaseYear {
    if (releaseDate == null || releaseDate!.isEmpty) return null;
    return DateFormat('yyyy-MM-dd').parse(releaseDate!).year;
  }

  Movie({
      this.adult, 
      this.backdropPath, 
      this.genreIds, 
      this.id, 
      this.originalLanguage, 
      this.originalTitle, 
      this.overview, 
      this.popularity, 
      this.posterPath, 
      this.releaseDate, 
      this.title, 
      this.video, 
      this.voteAverage, 
      this.voteCount});

  Movie.fromJson(dynamic json) {
    adult = json["adult"];
    backdropPath = json["backdrop_path"];
    genreIds = json["genre_ids"] != null ? json["genre_ids"].cast<int>() : [];
    id = json["id"];
    originalLanguage = json["original_language"];
    originalTitle = json["original_title"];
    overview = json["overview"];
    popularity = json["popularity"];
    posterPath = json["poster_path"];
    releaseDate = json["release_date"];
    title = json["title"];
    video = json["video"];
    voteAverage = json["vote_average"];
    voteCount = json["vote_count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["adult"] = adult;
    map["backdrop_path"] = backdropPath;
    map["genre_ids"] = genreIds;
    map["id"] = id;
    map["original_language"] = originalLanguage;
    map["original_title"] = originalTitle;
    map["overview"] = overview;
    map["popularity"] = popularity;
    map["poster_path"] = posterPath;
    map["release_date"] = releaseDate;
    map["title"] = title;
    map["video"] = video;
    map["vote_average"] = voteAverage;
    map["vote_count"] = voteCount;
    return map;
  }

}