import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_crud/providers/item_provider.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item List"),
      ),
      body: Consumer<ItemProvider>(builder: (context, provider, index) {
        return provider.itemList.isEmpty
            ? Center(child: Text("There is no any item"))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: provider.itemList.length,
                itemBuilder: (context, index) {
                  final item = provider.itemList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (item.image != null)
                              SizedBox(
                                  height: 48,
                                  width: 48,
                                  child: Image.memory(item.image!)),
                            Column(
                              children: [
                                Text(item.title),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(item.description)
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  provider.deleteItem(item.id!);
                                },
                                icon: Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.redAccent,
                                )),
                            IconButton(
                                onPressed: () {
                                  provider.updateItem(item);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.redAccent,
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
      }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: Colors.pinkAccent,
              onPressed: () {
                context.read<ItemProvider>().pickImage();
              }),
          FloatingActionButton(onPressed: () {
            context.read<ItemProvider>().addItem();
          }),
        ],
      ),
    );
  }
}
