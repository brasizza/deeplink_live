// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostModel {
  final int id;
  final DateTime date;
  final String title;
  final String description;
  final String slug;
  final String? image;
  PostModel({
    required this.id,
    required this.date,
    required this.title,
    required this.slug,
    required this.description,
    this.image,
  });

  PostModel copyWith({
    int? id,
    DateTime? date,
    String? title,
    String? description,
    String? slug,
    String? image,
  }) {
    return PostModel(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      slug: slug ?? this.slug,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'title': title,
      'description': description,
      'image': image,
      'slug': slug,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as int,
      date: DateTime.parse(map['date']),
      title: map['title']['rendered'] as String,
      slug: map['slug'] as String,
      description: map['content']['rendered'] as String,
      image: map['_embedded']['wp:featuredmedia'][0]["source_url"] != null ? map['_embedded']['wp:featuredmedia'][0]["source_url"] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(id: $id, date: $date, title: $title, description: $description, slug: $slug, image: $image)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.date == date && other.title == title && other.description == description && other.slug == slug && other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ date.hashCode ^ title.hashCode ^ description.hashCode ^ slug.hashCode ^ image.hashCode;
  }
}
