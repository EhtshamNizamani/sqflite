import 'dart:typed_data';

class Item {
  final int? id;
  final String title;
  final String description;
  final Uint8List? image;

  Item({this.id, this.image, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      image: map['image'],
    );
  }
}
