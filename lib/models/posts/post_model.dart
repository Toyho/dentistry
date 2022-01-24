class Post {
  Post({
      List<Posts>? posts,}){
    _posts = posts;
}

  Post.fromJson(dynamic json) {
      _posts = [];
      json.forEach((v) {
        _posts?.add(Posts.fromJson(v));
      });
  }
  List<Posts>? _posts;

  List<Posts>? get posts => _posts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_posts != null) {
      map['posts'] = _posts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Posts {
  Posts({
      String? text, 
      String? image,}){
    _text = text;
    _image = image;
}

  Posts.fromJson(dynamic json) {
    if (json != null) {
      _text = json['text'];
      _image = json['image'];
    }
  }
  String? _text;
  String? _image;

  String? get text => _text;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['image'] = _image;
    return map;
  }

}