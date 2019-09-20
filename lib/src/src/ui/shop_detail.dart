import 'package:flutter/material.dart';
import '../blocs/shops_items_bloc.dart';
import '../blocs/shop_items_bloc_provider.dart';
import '../models/shop_items_model.dart';

class Shopdetail extends StatefulWidget {
  final int id;
  final String backgroundPath;
  final String logoPath;
  final String name;
  final String description;
  final List<int> sundayHours;
  final List<int> mondayHours;
  final List<int> tuesdayHours;
  final List<int> wednesdayHours;
  final List<int> thursdayHours;
  final List<int> fridayHours;
  final List<int> saturdayHours;
  final Color backgroundColor;

  Shopdetail(
      {this.name,
      this.description,
      this.logoPath,
      this.backgroundPath,
      this.backgroundColor,
      this.id,
      this.fridayHours,
      this.mondayHours,
      this.saturdayHours,
      this.sundayHours,
      this.thursdayHours,
      this.tuesdayHours,
      this.wednesdayHours});

  @override
  _ShopdetailState createState() => _ShopdetailState(
      id: id,
      name: name,
      description: description,
      logoPath: logoPath,
      backgroundPath: backgroundPath,
      colorBackground: backgroundColor,
      sundayHours: sundayHours,
      mondayHours: mondayHours,
      fridayHours: fridayHours,
      saturdayHours: saturdayHours,
      thursdayHours: thursdayHours,
      tuesdayHours: tuesdayHours,
      wednesdayHours: wednesdayHours);
}

class _ShopdetailState extends State<Shopdetail> {
  final int id;
  final String backgroundPath;
  final String logoPath;
  final String name;
  final String description;
  final List<int> sundayHours;
  final List<int> mondayHours;
  final List<int> tuesdayHours;
  final List<int> wednesdayHours;
  final List<int> thursdayHours;
  final List<int> fridayHours;
  final List<int> saturdayHours;
  final Color colorBackground;

  _ShopdetailState(
      {this.name,
      this.description,
      this.logoPath,
      this.backgroundPath,
      this.colorBackground,
      this.id,
      this.fridayHours,
      this.mondayHours,
      this.saturdayHours,
      this.sundayHours,
      this.thursdayHours,
      this.tuesdayHours,
      this.wednesdayHours});

  ShopItemsBloc bloc;
  int initialList;
  int resultsLength;
  bool loadMore;

  @override
  void didChangeDependencies() {
    bloc = ShopItemsBlocProvider.of(context);
    bloc.fetchItemsById(id);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    loadMore = true;
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                backgroundColor: colorBackground,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  backgroundPath,
                  fit: BoxFit.cover,
                )),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                shopInfo(),
                emptySpace(8.0),
                openingHours(),
                Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                shopItems()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget shopInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        emptySpace(8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(
              logoPath,
              height: 100.0,
              width: 100.0,
            ),
            (description.length > 0)
                ? Text(
                    description,
                  )
                : Text('Description not available'),
          ],
        ),
      ],
    );
  }

  Widget shopItems() {
    return Expanded(
      child: StreamBuilder(
        stream: bloc.shopItems,
        builder: (context, AsyncSnapshot<Future<ItemModel>> snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
              future: snapshot.data,
              builder: (context, AsyncSnapshot<ItemModel> itemSnapShot) {
                if (itemSnapShot.hasData) {
                  if (itemSnapShot.data.results.length > 0) {
                    return itemsLayout(itemSnapShot.data);
                  } else
                    return noItems(itemSnapShot.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget openingHours() {
    // column widget that displays opening hours for the shop
    return Column(
      children: <Widget>[
        Text('Opening hours',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            )),
        emptySpace(8.0),
        dayRow(sundayHours, 'Sunday'),
        emptySpace(5.0),
        dayRow(mondayHours, 'Monday'),
        emptySpace(5.0),
        dayRow(tuesdayHours, 'Tuesday'),
        emptySpace(5.0),
        dayRow(wednesdayHours, 'Wednesday'),
        emptySpace(5.0),
        dayRow(thursdayHours, 'Thursday'),
        emptySpace(5.0),
        dayRow(fridayHours, 'Friday'),
        emptySpace(5.0),
        dayRow(saturdayHours, 'Saturday'),
      ],
    );
  }

  Widget emptySpace(double space) {
    // empty widget that is used as the space between other widgets
    return Container(margin: EdgeInsets.only(top: space, bottom: space));
  }

  Widget dayRow(List<int> day, String name) {
    // row widget that displays the opening hours for a day
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[Text(name), hoursWidget(day)],
    );
  }

  Widget hoursWidget(List<int> day) {
    // Text widget that takes the day list and extract the openeing hours for that day
    return day.isNotEmpty
        ? Text(day.first.toString() + ':00 - ' + day.last.toString() + ':00')
        : Text('Not available');
  }

  Widget noItems(ItemModel data) {
    // Text widget to show when there are no items in the shop in context
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }

  Widget itemsLayout(ItemModel data) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: (!loadMore) ? data.results.length : 4, //data.results.length,
        itemBuilder: (BuildContext context, int index) {
          return productItem(data, index);
        });
  }

  Widget productItem(ItemModel data, int index) {
    if (loadMore && index == 3) {
      return loadmoreButton();
    } else {
      return ListTile(
        leading: Image.network(
          data.results[index].image,
          height: 100.0,
          width: 100.0,
        ),
        title: Text(data.results[index].name),
        subtitle: Text(data.results[index].price.toString() + 'Cents'),
        trailing: data.results[index].available
            ? Icon(Icons.add_shopping_cart)
            : Icon(Icons.remove_shopping_cart),
      );
    }
  }

  Widget loadmoreButton() {
    return Visibility(
      visible: loadMore,
      child: RaisedButton(
        child: Text('Load more'),
        onPressed: () {
          setState(() {
            loadMore = !loadMore;
          });
        },
      ),
    );
  }
}
