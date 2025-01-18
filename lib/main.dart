import 'package:flutter/material.dart';
import 'package:sqflite_crud/providers/item_provider.dart';
import 'package:sqflite_crud/services/locator.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<ItemProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SQLite & Provider',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Text("Testing"),
      ),
    );
  }
}
