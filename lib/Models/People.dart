class People {
  People({
    num? page,
    List<Results>? results,
    num? totalPages,
    num? totalResults,
  }) {
    _page = page;
    _results = results;
    _totalPages = totalPages;
    _totalResults = totalResults;
  }

  People.fromJson(dynamic json) {
    _page = json['page'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
    _totalPages = json['total_pages'];
    _totalResults = json['total_results'];
  }
  num? _page;
  List<Results>? _results;
  num? _totalPages;
  num? _totalResults;
  People copyWith({
    num? page,
    List<Results>? results,
    num? totalPages,
    num? totalResults,
  }) =>
      People(
        page: page ?? _page,
        results: results ?? _results,
        totalPages: totalPages ?? _totalPages,
        totalResults: totalResults ?? _totalResults,
      );
  num? get page => _page;
  List<Results>? get results => _results;
  num? get totalPages => _totalPages;
  num? get totalResults => _totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = _totalPages;
    map['total_results'] = _totalResults;
    return map;
  }
}

class Results {
  Results({
    num? id,
    String? name,
    String? originalName,
    String? mediaType,
    bool? adult,
    num? popularity,
    num? gender,
    String? knownForDepartment,
    String? profilePath,
    List<KnownFor>? knownFor,
  }) {
    _id = id;
    _name = name;
    _originalName = originalName;
    _mediaType = mediaType;
    _adult = adult;
    _popularity = popularity;
    _gender = gender;
    _knownForDepartment = knownForDepartment;
    _profilePath = profilePath;
    _knownFor = knownFor;
  }

  Results.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _originalName = json['original_name'];
    _mediaType = json['media_type'];
    _adult = json['adult'];
    _popularity = json['popularity'];
    _gender = json['gender'];
    _knownForDepartment = json['known_for_department'];
    _profilePath = json['profile_path'];
    if (json['known_for'] != null) {
      _knownFor = [];
      json['known_for'].forEach((v) {
        _knownFor?.add(KnownFor.fromJson(v));
      });
    }
  }
  num? _id;
  String? _name;
  String? _originalName;
  String? _mediaType;
  bool? _adult;
  num? _popularity;
  num? _gender;
  String? _knownForDepartment;
  String? _profilePath;
  List<KnownFor>? _knownFor;
  Results copyWith({
    num? id,
    String? name,
    String? originalName,
    String? mediaType,
    bool? adult,
    num? popularity,
    num? gender,
    String? knownForDepartment,
    String? profilePath,
    List<KnownFor>? knownFor,
  }) =>
      Results(
        id: id ?? _id,
        name: name ?? _name,
        originalName: originalName ?? _originalName,
        mediaType: mediaType ?? _mediaType,
        adult: adult ?? _adult,
        popularity: popularity ?? _popularity,
        gender: gender ?? _gender,
        knownForDepartment: knownForDepartment ?? _knownForDepartment,
        profilePath: profilePath ?? _profilePath,
        knownFor: knownFor ?? _knownFor,
      );
  num? get id => _id;
  String? get name => _name;
  String? get originalName => _originalName;
  String? get mediaType => _mediaType;
  bool? get adult => _adult;
  num? get popularity => _popularity;
  num? get gender => _gender;
  String? get knownForDepartment => _knownForDepartment;
  String? get profilePath => _profilePath;
  List<KnownFor>? get knownFor => _knownFor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['original_name'] = _originalName;
    map['media_type'] = _mediaType;
    map['adult'] = _adult;
    map['popularity'] = _popularity;
    map['gender'] = _gender;
    map['known_for_department'] = _knownForDepartment;
    map['profile_path'] = _profilePath;
    if (_knownFor != null) {
      map['known_for'] = _knownFor?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class KnownFor {
  KnownFor({
    String? backdropPath,
    num? id,
    String? title,
    String? originalTitle,
    String? overview,
    String? posterPath,
    String? mediaType,
    bool? adult,
    String? originalLanguage,
    List<num>? genreIds,
    num? popularity,
    String? releaseDate,
    bool? video,
    num? voteAverage,
    num? voteCount,
  }) {
    _backdropPath = backdropPath;
    _id = id;
    _title = title;
    _originalTitle = originalTitle;
    _overview = overview;
    _posterPath = posterPath;
    _mediaType = mediaType;
    _adult = adult;
    _originalLanguage = originalLanguage;
    _genreIds = genreIds;
    _popularity = popularity;
    _releaseDate = releaseDate;
    _video = video;
    _voteAverage = voteAverage;
    _voteCount = voteCount;
  }

  KnownFor.fromJson(dynamic json) {
    _backdropPath = json['backdrop_path'];
    _id = json['id'];
    _title = json['title'];
    _originalTitle = json['original_title'];
    _overview = json['overview'];
    _posterPath = json['poster_path'];
    _mediaType = json['media_type'];
    _adult = json['adult'];
    _originalLanguage = json['original_language'];
    _genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<num>() : [];
    _popularity = json['popularity'];
    _releaseDate = json['release_date'];
    _video = json['video'];
    _voteAverage = json['vote_average'];
    _voteCount = json['vote_count'];
  }
  String? _backdropPath;
  num? _id;
  String? _title;
  String? _originalTitle;
  String? _overview;
  String? _posterPath;
  String? _mediaType;
  bool? _adult;
  String? _originalLanguage;
  List<num>? _genreIds;
  num? _popularity;
  String? _releaseDate;
  bool? _video;
  num? _voteAverage;
  num? _voteCount;
  KnownFor copyWith({
    String? backdropPath,
    num? id,
    String? title,
    String? originalTitle,
    String? overview,
    String? posterPath,
    String? mediaType,
    bool? adult,
    String? originalLanguage,
    List<num>? genreIds,
    num? popularity,
    String? releaseDate,
    bool? video,
    num? voteAverage,
    num? voteCount,
  }) =>
      KnownFor(
        backdropPath: backdropPath ?? _backdropPath,
        id: id ?? _id,
        title: title ?? _title,
        originalTitle: originalTitle ?? _originalTitle,
        overview: overview ?? _overview,
        posterPath: posterPath ?? _posterPath,
        mediaType: mediaType ?? _mediaType,
        adult: adult ?? _adult,
        originalLanguage: originalLanguage ?? _originalLanguage,
        genreIds: genreIds ?? _genreIds,
        popularity: popularity ?? _popularity,
        releaseDate: releaseDate ?? _releaseDate,
        video: video ?? _video,
        voteAverage: voteAverage ?? _voteAverage,
        voteCount: voteCount ?? _voteCount,
      );
  String? get backdropPath => _backdropPath;
  num? get id => _id;
  String? get title => _title;
  String? get originalTitle => _originalTitle;
  String? get overview => _overview;
  String? get posterPath => _posterPath;
  String? get mediaType => _mediaType;
  bool? get adult => _adult;
  String? get originalLanguage => _originalLanguage;
  List<num>? get genreIds => _genreIds;
  num? get popularity => _popularity;
  String? get releaseDate => _releaseDate;
  bool? get video => _video;
  num? get voteAverage => _voteAverage;
  num? get voteCount => _voteCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['backdrop_path'] = _backdropPath;
    map['id'] = _id;
    map['title'] = _title;
    map['original_title'] = _originalTitle;
    map['overview'] = _overview;
    map['poster_path'] = _posterPath;
    map['media_type'] = _mediaType;
    map['adult'] = _adult;
    map['original_language'] = _originalLanguage;
    map['genre_ids'] = _genreIds;
    map['popularity'] = _popularity;
    map['release_date'] = _releaseDate;
    map['video'] = _video;
    map['vote_average'] = _voteAverage;
    map['vote_count'] = _voteCount;
    return map;
  }
}
