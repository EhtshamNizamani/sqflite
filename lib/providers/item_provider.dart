import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sqflite_crud/data/db_helper.dart';
import 'package:sqflite_crud/models/item.dart';
import 'package:image_picker/image_picker.dart';

class ItemProvider with ChangeNotifier {
  List<Item> itemList = <Item>[];
  final DBHelper _dbHelper = DBHelper();
  Uint8List? bytes;

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Convert the image to a byte array (Uint8List)
      bytes = await image.readAsBytes();

      // Insert into the database
    }
  }

  Future<void> fetchItem() async {
    try {
      itemList = await _dbHelper.getItem();
      notifyListeners();
    } catch (e) {
      print("Error in fetchItem: $e");
    }
  }

  Future<void> addItem() async {
    try {
      // Create an Item with the image bytes
      Item newItem = Item(
        title: 'Item Title',
        description: 'Item Description',
        image: bytes,
      );

      await _dbHelper.insertItem(newItem);

      await fetchItem();
    } catch (e) {
      print("Error in InsertItem: $e");
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      final row = await _dbHelper.deleteItem(id);
      print("This item is delte at row number $row");
      await fetchItem();
    } catch (e) {
      print("Error in deleteItem: $e");
    }
  }

  Future<void> updateItem(Item item) async {
    try {
      Map<String, dynamic> updatedItem = {
        "title": "Updated Item ",
        "description": "update description"
      };

      await _dbHelper.updateItem(updatedItem, item.id!);
      await fetchItem();
      notifyListeners();
    } catch (e) {
      print("Error in updateItem: $e");
    }
  }
}
