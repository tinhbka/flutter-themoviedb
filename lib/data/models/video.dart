/// iso_639_1 : "en"
/// iso_3166_1 : "US"
/// name : "Trailer"
/// key : "PLl99DlL6b4"
/// site : "YouTube"
/// size : 1080
/// type : "Trailer"
/// official : true
/// published_at : "2021-07-27 19:59:46 UTC"
/// id : "6100de6e22931a00297462fe"

class VideoResponse {
  List<Video>? data;

  VideoResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> dataList = json['results'];
    if (dataList != null) {
      data = dataList.map((e) => Video.fromJson(e)).toList();
    }
  }
}

class Video {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;

  Video({
      this.iso6391, 
      this.iso31661, 
      this.name, 
      this.key, 
      this.site, 
      this.size, 
      this.type, 
      this.official, 
      this.publishedAt, 
      this.id});

  Video.fromJson(dynamic json) {
    iso6391 = json["iso_639_1"];
    iso31661 = json["iso_3166_1"];
    name = json["name"];
    key = json["key"];
    site = json["site"];
    size = json["size"];
    type = json["type"];
    official = json["official"];
    publishedAt = json["published_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["iso_639_1"] = iso6391;
    map["iso_3166_1"] = iso31661;
    map["name"] = name;
    map["key"] = key;
    map["site"] = site;
    map["size"] = size;
    map["type"] = type;
    map["official"] = official;
    map["published_at"] = publishedAt;
    map["id"] = id;
    return map;
  }

}