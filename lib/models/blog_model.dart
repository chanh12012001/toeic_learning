class Blog {
  String? createdAt;
  String? title;
  String? content;
  List<Images>? images;
  String? id;

  Blog({this.createdAt, this.title, this.content, this.images, this.id});

  Blog.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    title = json['title'];
    content = json['content'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['createdAt'] = createdAt;
    data['title'] = title;
    data['content'] = content;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class Images {
  String? imageUrl;
  String? cloudinaryId;
  String? id;

  Images({this.imageUrl, this.cloudinaryId, this.id});

  Images.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    cloudinaryId = json['cloudinaryId'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['imageUrl'] = imageUrl;
    data['cloudinaryId'] = cloudinaryId;
    data['_id'] = id;
    return data;
  }
}
