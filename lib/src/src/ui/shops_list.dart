import 'package:flutter/material.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import '../models/shop_model.dart';
import '../blocs/shops_bloc.dart';
import '../ui/shop_detail.dart';
import '../blocs/shop_items_bloc_provider.dart';

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
        builder: (context, AsyncSnapshot<ShopModel> snapshot) {
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

  Widget buildList(AsyncSnapshot<ShopModel> snapshot) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: snapshot.data.results.length,
        itemBuilder: (BuildContext context, int index) {
          return shopItem(snapshot, index);
        });
  }

  Widget shopItem(AsyncSnapshot<ShopModel> snapshot, int index) {
    String _logopath = snapshot.data.results[index].logoPath;
    return GestureDetector(
      onTap: () => openDetailPage(context, snapshot.data, index),
      child: Container(
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
          )),
    );
  }
}

Widget shopInfo(AsyncSnapshot<ShopModel> snapshot, int index) {
  String _name = snapshot.data.results[index].storename;
  String _address;
  List<String> _addressList = snapshot.data.results[index].address;
  (_addressList.length > 0) ? _address = _addressList.first : _address = '';
  String _description = snapshot.data.results[index].storeDescription;

  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _name,
        ),
        (_description.length > 0)
            ? Text(
                _description.substring(0, 59),
              )
            : Text('Description not available'),
        (_address.length > 0)
            ? Text(
                _address,
              )
            : Text('Shop address not available'),
      ],
    ),
  );
}

openDetailPage(BuildContext context, ShopModel data, int index) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return ShopItemsBlocProvider(
        child: Shopdetail(
          id: data.results[index].id,
          name: data.results[index].name,
          backgroundPath: data.results[index].backgroud,
          description: data.results[index].description,
          logoPath: data.results[index].logo,
          fridayHours: data.results[index].fridayHours,
          mondayHours: data.results[index].mondayHours,
          saturdayHours: data.results[index].saturdayHours,
          sundayHours: data.results[index].sundayHours,
          thursdayHours: data.results[index].thursdayHours,
          tuesdayHours: data.results[index].tuesdayHours,
          wednesdayHours: data.results[index].wednesdayHours,
          backgroundColor: data.results[index].color,
        ),
      );
    }),
  );
}
