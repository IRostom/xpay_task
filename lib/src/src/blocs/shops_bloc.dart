import '../repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/shop_model.dart';

class ShopsBloc {
  final _repository = Repository();
  final _shopsFetcher = PublishSubject<ShopModel>();

  Observable<ShopModel> get allshops => _shopsFetcher.stream;

  fetchAllShops() async {
    ShopModel itemModel = await _repository.fetchAllShops();
    _shopsFetcher.sink.add(itemModel);
  }

  dispose() {
    _shopsFetcher.close();
  }
}

final bloc = ShopsBloc();