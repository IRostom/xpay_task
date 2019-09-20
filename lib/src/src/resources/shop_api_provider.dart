import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:xpay_task/src/src/models/shop_items_model.dart';
import 'dart:convert';
import '../models/shop_model.dart';

class ShopApiProvider {
  Client client = Client();

  Future<ShopModel> fetchShopList() async {
    print("entered");
    final response = await client
        .get("https://api.unocart.com/api/v1/2000/groceries/shops/");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ShopModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<ItemModel> fetchItemsList(int shopId) async {
    final response = await client.get(
        "https://api.unocart.com/api/v1/6000/groceries/shops/$shopId/specials/");
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body), );
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}
