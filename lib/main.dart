import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

import 'api/item.dart';
import 'catalog.dart';
import 'item_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Catalog>(
      create: (context) => Catalog(),
      child: MaterialApp(
        title: 'Infinite List',
        theme: ThemeData.light(useMaterial3: true),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite List'),
      ),
      body: Selector<Catalog, int?>(
        selector: (context, catalog) => catalog.itemCount,
        builder: (context, itemCount, child) => ListView.builder(
          itemCount: itemCount,
          padding: const EdgeInsets.symmetric(vertical: 18),
          itemBuilder: (context, index) {
            var catalog = Provider.of<Catalog>(context);
            return switch (catalog.getByIndex(index)) {
              Item(isLoading: true) => const LoadingItemTile(),
              var item => ItemTile(item: item)
            };
          },
        ),
      ),
    );
  }
}
