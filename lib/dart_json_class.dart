// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart';

class HttpService{

  final String postsURL = "https://drnyotwanawng.com/api/posts";

  Future<List<Posts>?> getPosts() async{
    Response res = await get(Uri.parse(postsURL));

    if (res.statusCode == 200) {

        List<dynamic> body = [jsonDecode(res.body)];

        List<Posts> dataposts = body
          .map((dynamic item) => Posts.fromJson(item)) .toList();

          return dataposts;
    }else{
      throw "Unable to retrieve dataposts"; 
    }
  }
}

//  List<Posts> postsFromJson(String str) => List<Posts>.from(json.decode(str).map((x) => Posts.fromJson(x)));
//  String postsToJson(List<Posts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Posts {
  

    Posts({
       this.data,
       this.links,
       this.meta,
    });

    List<Datum>? data;
    Links? links;
    Meta? meta;

    factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        //data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        //"data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links!.toJson(),
        "meta": meta!.toJson(),
    };
}

class Datum {
    Datum({
        this.id,
        this.title,
        this.category,
        this.date,
        this.video,
        this.image,
    });

    String? id;
    String? title;
    // Category? category;
    String? category;
    String? date;
    dynamic video;
    String? image;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        // category: categoryValues.map[json["category"]],
        category: json["category"],
        date: json["date"],
        video: json["video"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        // "category": categoryValues.reverse![category],
        "category": category,
        "date": date,
        "video": video,
        "image": image,
    };
}

enum Category { BLOG, ARTICLE, POEM }

final categoryValues = EnumValues({
    "article": Category.ARTICLE,
    "blog": Category.BLOG,
    "poem": Category.POEM
});

class Links {
    Links({
        this.first,
        this.last,
        this.prev,
        this.next,
    });

    String? first;
    String? last;
    dynamic prev;
    String? next;

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
    );

    Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
    };
}

class Meta {
    Meta({
        this.currentPage,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total,
    });

    int? currentPage;
    int? from;
    int? lastPage;
    String? path;
    int? perPage;
    int? to;
    int? total;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

