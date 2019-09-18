import '../repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

class ShopsBloc {
  final _repository = Repository();
  final _shopsFetcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get allshops => _shopsFetcher.stream;

  fetchAllShops() async {
    ItemModel itemModel = await _repository.fetchAllShops();
    _shopsFetcher.sink.add(itemModel);
  }

  dispose() {
    _shopsFetcher.close();
  }
}

final bloc = ShopsBloc();