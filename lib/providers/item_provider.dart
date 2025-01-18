import 'package:flutter/material.dart';
import 'package:sqflite_crud/data/db_helper.dart';
import 'package:sqflite_crud/models/item.dart';

class ItemProvider with ChangeNotifier {
  List<Item> itemList = <Item>[];
  final DBHelper _dbHelper = DBHelper();

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
      await _dbHelper.insertItem(
          Item(title: "This is Title", description: "This is descrption"));
      await fetchItem();
    } catch (e) {
      print("Error in InsertItem: $e");
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      final row = await _dbHelper.deleteItem(id);
      print("This item is delte at row number $row");
      fetchItem();
      notifyListeners();
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
      fetchItem();
      fetchItem();
      notifyListeners();
    } catch (e) {
      print("Error in updateItem: $e");
    }
  }
}
