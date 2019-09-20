import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../models/shop_items_model.dart';
import '../repository/repository.dart';

class ShopItemsBloc {
  final _repository = Repository();
  final _shopId = PublishSubject<int>();
  final _items = BehaviorSubject<Future<ItemModel>>();

  Function(int) get fetchItemsById => _shopId.sink.add;
  Observable<Future<ItemModel>> get shopItems => _items.stream;

  ShopItemsBloc() {
    _shopId.stream.transform(_itemTransformer()).pipe(_items);
  }

  dispose() async {
    _shopId.close();
    await _items.drain();
    _items.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
      (Future<ItemModel> items, int id, int index) {
        print(index);
        items = _repository.fetchItems(id);
        return items;
      },
    );
  }
}