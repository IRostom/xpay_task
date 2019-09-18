import 'dart:async';
import '../resources/shop_api_provider.dart';
import '../models/item_model.dart';

class Repository {
  final shopApiProvider = ShopApiProvider();

  Future<ItemModel> fetchAllShops() => shopApiProvider.fetchShopList();
}