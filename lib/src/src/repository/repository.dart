import 'dart:async';
import '../resources/shop_api_provider.dart';
import '../models/shop_model.dart';
import '../models/shop_items_model.dart';

class Repository {
  final shopApiProvider = ShopApiProvider();
  Future<ShopModel> fetchAllShops() => shopApiProvider.fetchShopList();
  Future<ItemModel> fetchItems(int shopId) => shopApiProvider.fetchItemsList(shopId);
}