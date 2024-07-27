class ImageUrls {
  ImageUrls({
    List<Backdrops>? backdrops,
    num? id,
    List<Logos>? logos,
    List<Posters>? posters,
  }) {
    _backdrops = backdrops;
    _id = id;
    _logos = logos;
    _posters = posters;
  }

  ImageUrls.fromJson(dynamic json) {
    if (json['backdrops'] != null) {
      _backdrops = [];
      json['backdrops'].forEach((v) {
        _backdrops?.add(Backdrops.fromJson(v));
      });
    }
    _id = json['id'];
    if (json['logos'] != null) {
      _logos = [];
      json['logos'].forEach((v) {
        _logos?.add(Logos.fromJson(v));
      });
    }
    if (json['posters'] != null) {
      _posters = [];
      json['posters'].forEach((v) {
        _posters?.add(Posters.fromJson(v));
      });
    }
  }
  List<Backdrops>? _backdrops;
  num? _id;
  List<Logos>? _logos;
  List<Posters>? _posters;
  ImageUrls copyWith({
    List<Backdrops>? backdrops,
    num? id,
    List<Logos>? logos,
    List<Posters>? posters,
  }) =>
      ImageUrls(
        backdrops: backdrops ?? _backdrops,
        id: id ?? _id,
        logos: logos ?? _logos,
        posters: posters ?? _posters,
      );
  List<Backdrops>? get backdrops => _backdrops;
  num? get id => _id;
  List<Logos>? get logos => _logos;
  List<Posters>? get posters => _posters;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_backdrops != null) {
      map['backdrops'] = _backdrops?.map((v) => v.toJson()).toList();
    }
    map['id'] = _id;
    if (_logos != null) {
      map['logos'] = _logos?.map((v) => v.toJson()).toList();
    }
    if (_posters != null) {
      map['posters'] = _posters?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Posters {
  Posters({
    num? aspectRatio,
    num? height,
    String? iso6391,
    String? filePath,
    num? voteAverage,
    num? voteCount,
    num? width,
  }) {
    _aspectRatio = aspectRatio;
    _height = height;
    _iso6391 = iso6391;
    _filePath = filePath;
    _voteAverage = voteAverage;
    _voteCount = voteCount;
    _width = width;
  }

  Posters.fromJson(dynamic json) {
    _aspectRatio = json['aspect_ratio'];
    _height = json['height'];
    _iso6391 = json['iso_639_1'];
    _filePath = json['file_path'];
    _voteAverage = json['vote_average'];
    _voteCount = json['vote_count'];
    _width = json['width'];
  }
  num? _aspectRatio;
  num? _height;
  String? _iso6391;
  String? _filePath;
  num? _voteAverage;
  num? _voteCount;
  num? _width;
  Posters copyWith({
    num? aspectRatio,
    num? height,
    String? iso6391,
    String? filePath,
    num? voteAverage,
    num? voteCount,
    num? width,
  }) =>
      Posters(
        aspectRatio: aspectRatio ?? _aspectRatio,
        height: height ?? _height,
        iso6391: iso6391 ?? _iso6391,
        filePath: filePath ?? _filePath,
        voteAverage: voteAverage ?? _voteAverage,
        voteCount: voteCount ?? _voteCount,
        width: width ?? _width,
      );
  num? get aspectRatio => _aspectRatio;
  num? get height => _height;
  String? get iso6391 => _iso6391;
  String? get filePath => _filePath;
  num? get voteAverage => _voteAverage;
  num? get voteCount => _voteCount;
  num? get width => _width;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aspect_ratio'] = _aspectRatio;
    map['height'] = _height;
    map['iso_639_1'] = _iso6391;
    map['file_path'] = _filePath;
    map['vote_average'] = _voteAverage;
    map['vote_count'] = _voteCount;
    map['width'] = _width;
    return map;
  }
}

class Logos {
  Logos({
    num? aspectRatio,
    num? height,
    String? iso6391,
    String? filePath,
    num? voteAverage,
    num? voteCount,
    num? width,
  }) {
    _aspectRatio = aspectRatio;
    _height = height;
    _iso6391 = iso6391;
    _filePath = filePath;
    _voteAverage = voteAverage;
    _voteCount = voteCount;
    _width = width;
  }

  Logos.fromJson(dynamic json) {
    _aspectRatio = json['aspect_ratio'];
    _height = json['height'];
    _iso6391 = json['iso_639_1'];
    _filePath = json['file_path'];
    _voteAverage = json['vote_average'];
    _voteCount = json['vote_count'];
    _width = json['width'];
  }
  num? _aspectRatio;
  num? _height;
  String? _iso6391;
  String? _filePath;
  num? _voteAverage;
  num? _voteCount;
  num? _width;
  Logos copyWith({
    num? aspectRatio,
    num? height,
    String? iso6391,
    String? filePath,
    num? voteAverage,
    num? voteCount,
    num? width,
  }) =>
      Logos(
        aspectRatio: aspectRatio ?? _aspectRatio,
        height: height ?? _height,
        iso6391: iso6391 ?? _iso6391,
        filePath: filePath ?? _filePath,
        voteAverage: voteAverage ?? _voteAverage,
        voteCount: voteCount ?? _voteCount,
        width: width ?? _width,
      );
  num? get aspectRatio => _aspectRatio;
  num? get height => _height;
  String? get iso6391 => _iso6391;
  String? get filePath => _filePath;
  num? get voteAverage => _voteAverage;
  num? get voteCount => _voteCount;
  num? get width => _width;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aspect_ratio'] = _aspectRatio;
    map['height'] = _height;
    map['iso_639_1'] = _iso6391;
    map['file_path'] = _filePath;
    map['vote_average'] = _voteAverage;
    map['vote_count'] = _voteCount;
    map['width'] = _width;
    return map;
  }
}

class Backdrops {
  Backdrops({
    num? aspectRatio,
    num? height,
    String? iso6391,
    String? filePath,
    num? voteAverage,
    num? voteCount,
    num? width,
  }) {
    _aspectRatio = aspectRatio;
    _height = height;
    _iso6391 = iso6391;
    _filePath = filePath;
    _voteAverage = voteAverage;
    _voteCount = voteCount;
    _width = width;
  }

  Backdrops.fromJson(dynamic json) {
    _aspectRatio = json['aspect_ratio'];
    _height = json['height'];
    _iso6391 = json['iso_639_1'];
    _filePath = json['file_path'];
    _voteAverage = json['vote_average'];
    _voteCount = json['vote_count'];
    _width = json['width'];
  }
  num? _aspectRatio;
  num? _height;
  String? _iso6391;
  String? _filePath;
  num? _voteAverage;
  num? _voteCount;
  num? _width;
  Backdrops copyWith({
    num? aspectRatio,
    num? height,
    String? iso6391,
    String? filePath,
    num? voteAverage,
    num? voteCount,
    num? width,
  }) =>
      Backdrops(
        aspectRatio: aspectRatio ?? _aspectRatio,
        height: height ?? _height,
        iso6391: iso6391 ?? _iso6391,
        filePath: filePath ?? _filePath,
        voteAverage: voteAverage ?? _voteAverage,
        voteCount: voteCount ?? _voteCount,
        width: width ?? _width,
      );
  num? get aspectRatio => _aspectRatio;
  num? get height => _height;
  String? get iso6391 => _iso6391;
  String? get filePath => _filePath;
  num? get voteAverage => _voteAverage;
  num? get voteCount => _voteCount;
  num? get width => _width;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aspect_ratio'] = _aspectRatio;
    map['height'] = _height;
    map['iso_639_1'] = _iso6391;
    map['file_path'] = _filePath;
    map['vote_average'] = _voteAverage;
    map['vote_count'] = _voteCount;
    map['width'] = _width;
    return map;
  }
}
