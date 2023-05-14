class Blog {
  List<BlogResult>? results;

  Blog({this.results});

  Blog.fromJson(Map<String, dynamic> json) {
    results = json["results"] == null
        ? null
        : (json["results"] as List).map((e) => BlogResult.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data["results"] = results?.map((e) => e.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'results: $results';
  }
}

class BlogResult {
  int? id;
  String? title;
  String? subTitle;
  String? photo;
  String? content;
  String? author;
  int? createAt;
  String? tag;

  BlogResult(
      {this.id,
      this.title,
      this.subTitle,
      this.photo,
      this.content,
      this.author,
      this.createAt,
      this.tag});

  BlogResult.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    subTitle = json["subTitle"];
    photo = json["photo"];
    content = json["content"];
    author = json["author"];
    createAt = json["create_at"];
    tag = json["tag"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["subTitle"] = subTitle;
    data["photo"] = photo;
    data["content"] = content;
    data["author"] = author;
    data["create_at"] = createAt;
    data["tag"] = tag;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{ id: $id, title: $title, subTitle: $subTitle, photo: $photo, content: $content, author: $author, '
        'createAt: $createAt, tag: $tag  }';
  }
}
