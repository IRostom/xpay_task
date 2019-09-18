import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

class ShopApiProvider {
  Client client = Client();

  Future<ItemModel> fetchShopList() async {
    print("entered");
    final response = await client
        .get("https://api.unocart.com/api/v1/2000/groceries/shops/");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}