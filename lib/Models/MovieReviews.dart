class MovieReviews {
  MovieReviews({
    num? id,
    num? page,
    List<Results>? results,
    num? totalPages,
    num? totalResults,
  }) {
    _id = id;
    _page = page;
    _results = results;
    _totalPages = totalPages;
    _totalResults = totalResults;
  }

  MovieReviews.fromJson(dynamic json) {
    _id = json['id'];
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
  num? _id;
  num? _page;
  List<Results>? _results;
  num? _totalPages;
  num? _totalResults;
  MovieReviews copyWith({
    num? id,
    num? page,
    List<Results>? results,
    num? totalPages,
    num? totalResults,
  }) =>
      MovieReviews(
        id: id ?? _id,
        page: page ?? _page,
        results: results ?? _results,
        totalPages: totalPages ?? _totalPages,
        totalResults: totalResults ?? _totalResults,
      );
  num? get id => _id;
  num? get page => _page;
  List<Results>? get results => _results;
  num? get totalPages => _totalPages;
  num? get totalResults => _totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
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
    String? author,
    AuthorDetails? authorDetails,
    String? content,
    String? createdAt,
    String? id,
    String? updatedAt,
    String? url,
  }) {
    _author = author;
    _authorDetails = authorDetails;
    _content = content;
    _createdAt = createdAt;
    _id = id;
    _updatedAt = updatedAt;
    _url = url;
  }

  Results.fromJson(dynamic json) {
    _author = json['author'];
    _authorDetails = json['author_details'] != null
        ? AuthorDetails.fromJson(json['author_details'])
        : null;
    _content = json['content'];
    _createdAt = json['created_at'];
    _id = json['id'];
    _updatedAt = json['updated_at'];
    _url = json['url'];
  }
  String? _author;
  AuthorDetails? _authorDetails;
  String? _content;
  String? _createdAt;
  String? _id;
  String? _updatedAt;
  String? _url;
  Results copyWith({
    String? author,
    AuthorDetails? authorDetails,
    String? content,
    String? createdAt,
    String? id,
    String? updatedAt,
    String? url,
  }) =>
      Results(
        author: author ?? _author,
        authorDetails: authorDetails ?? _authorDetails,
        content: content ?? _content,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
        updatedAt: updatedAt ?? _updatedAt,
        url: url ?? _url,
      );
  String? get author => _author;
  AuthorDetails? get authorDetails => _authorDetails;
  String? get content => _content;
  String? get createdAt => _createdAt;
  String? get id => _id;
  String? get updatedAt => _updatedAt;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['author'] = _author;
    if (_authorDetails != null) {
      map['author_details'] = _authorDetails?.toJson();
    }
    map['content'] = _content;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    map['updated_at'] = _updatedAt;
    map['url'] = _url;
    return map;
  }
}

class AuthorDetails {
  AuthorDetails({
    String? name,
    String? username,
    dynamic avatarPath,
    num? rating,
  }) {
    _name = name;
    _username = username;
    _avatarPath = avatarPath;
    _rating = rating;
  }

  AuthorDetails.fromJson(dynamic json) {
    _name = json['name'];
    _username = json['username'];
    _avatarPath = json['avatar_path'];
    _rating = json['rating'];
  }
  String? _name;
  String? _username;
  dynamic _avatarPath;
  num? _rating;
  AuthorDetails copyWith({
    String? name,
    String? username,
    dynamic avatarPath,
    num? rating,
  }) =>
      AuthorDetails(
        name: name ?? _name,
        username: username ?? _username,
        avatarPath: avatarPath ?? _avatarPath,
        rating: rating ?? _rating,
      );
  String? get name => _name;
  String? get username => _username;
  dynamic get avatarPath => _avatarPath;
  num? get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['username'] = _username;
    map['avatar_path'] = _avatarPath;
    map['rating'] = _rating;
    return map;
  }
}
