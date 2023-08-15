import 'dart:math';
import 'package:flutter/material.dart';

import 'item.dart';
import 'page.dart';

const catalogLength = 100;

Future<ItemPage> fetchPage(int startingIndex) async {
  await Future<void>.delayed(const Duration(milliseconds: 500));

  if (startingIndex > catalogLength) {
    return ItemPage(
      items: [],
      startingIndex: startingIndex,
      hasNext: false,
    );
  }

  // The page of items is generated here.
  return ItemPage(
    items: List.generate(
        min(itemsPerPage, catalogLength - startingIndex),
        (index) => Item(
              color: Colors.primaries[index % Colors.primaries.length],
              name: 'Color #${startingIndex + index}',
              price: 50 + (index * 42) % 200,
            )),
    startingIndex: startingIndex,
    hasNext: startingIndex + itemsPerPage < catalogLength,
  );
}
