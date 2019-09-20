class ItemModel {
  List<_Result> _results = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    List<_Result> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Result result = _Result(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<_Result> get results => _results;

}

class _Result {
  String _name;
  int _price;
  String _image;
  bool _available;


  _Result(result) {
    _name = result['name'];
    _price = result['price_cents'];
    _image = result['images'][0]['img_url'];
    _available = result['is_available'];
  }


  String get name => _name;

  int get price => _price;

  String get image => _image;

  bool get available => _available;
}