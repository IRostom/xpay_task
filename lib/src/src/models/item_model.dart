class ItemModel {
  List<_Result> _results = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
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
  int storeId;
  String name;
  String logoPath;
  String backgroudPath;
  String backgroundColor;
  String storeDescription;
  List<String> storeAddress = [];

  _Result(result) {
    storeId = result['id'];
    name = result['name'];
    logoPath = result['logo_image'];
    backgroudPath = result['background_image'];
    backgroundColor= result['background_color'];
    storeDescription = result['description'];

    for (int i = 0; i < result['addresses'].length; i++) {
      storeAddress.add(result['addresses'][i]['unparsed'].toString());
    }
  }

  int get id => storeId;
  String get storename => name;
  String get logo => logoPath;
  String get backgroud => backgroundColor;
  String get description => storeDescription;
  String get color => backgroundColor;
  List<String> get address => storeAddress;
}