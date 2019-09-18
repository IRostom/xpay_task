import 'package:flutter/material.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import '../models/item_model.dart';
import '../blocs/shops_bloc.dart';

class ShopList extends StatefulWidget {
  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllShops();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shops List'),
      ),
      body: StreamBuilder(
        stream: bloc.allshops,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.results.length,
        itemBuilder: (BuildContext context, int index) {
          return shopItem(snapshot, index);
        });
  }

  Widget shopItem(AsyncSnapshot<ItemModel> snapshot, int index) {
    String _logopath = snapshot.data.results[index].logoPath;
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            (_logopath.length > 0)
                ? Image.network(
                    snapshot.data.results[index].logoPath.toString(),
                    height: 100.0,
                    width: 100.0,
                  )
                : Icon(Icons.error, size: 100),
            shopInfo(snapshot, index)
          ],
        ));
  }
}

Widget shopInfo(AsyncSnapshot<ItemModel> snapshot, int index) {
  int _id = snapshot.data.results[index].id;
  String _name = snapshot.data.results[index].storename;
  String _address;
  List<String> _addressList = snapshot.data.results[index].address;
  (_addressList.length > 0) ? _address = _addressList.first : _address = '';
  String _decription = snapshot.data.results[index].storeDescription;

  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (_name.length > 0)
            ? Text(
                _name,
              )
            : Text('Shop $_id'),
        (_decription.length > 0)
            ? Text(
                _decription.substring(0, 59),
                overflow: TextOverflow.clip,
              )
            : Text('Shop description not available'),
        (_address.length > 0)
            ? Text(
                _address,
                //overflow: TextOverflow.clip,
              )
            : Text('Shop address not available'),
      ],
    ),
  );
}
