import 'package:flutter/material.dart';
import 'shops_items_bloc.dart';
export 'shops_bloc.dart';

class ShopItemsBlocProvider extends InheritedWidget {
  final ShopItemsBloc bloc;

  ShopItemsBlocProvider({Key key, Widget child})
      : bloc = ShopItemsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static ShopItemsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ShopItemsBlocProvider)
            as ShopItemsBlocProvider)
        .bloc;
  }
}