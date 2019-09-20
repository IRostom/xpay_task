import 'package:flutter/material.dart';


class ShopModel {
  List<_Result> _results = [];

  ShopModel.fromJson(Map<String, dynamic> parsedJson) {
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
  Color backgroundColor;
  String storeDescription;
  List<String> storeAddress = [];
  List<int> sunday = [];
  List<int> monday = [];
  List<int> tuesday = [];
  List<int> wednesday = [];
  List<int> thursday = [];
  List<int> friday = [];
  List<int> saturday = [];

  _Result(result) {
    storeId = result['id'];
    name = result['name'];
    logoPath = result['logo_image'];
    backgroudPath = result['background_image'];
    result['background_color'].toString().isNotEmpty ?
    backgroundColor = getColorFromHex(result['background_color'].toString()) : 
    backgroundColor = Colors.white;
    storeDescription = result['description'];

    for (int i = 0; i < result['addresses'].length; i++) {
      storeAddress.add(result['addresses'][i]['unparsed'].toString());
    }

    getopeninghours(sunday, result, 'Sunday');
    String value;
    sunday.isNotEmpty ? value = sunday.first.toString() : value = 'not available';
    print('Sunday:   ' + value);
    getopeninghours(monday, result, 'Monday');
    getopeninghours(tuesday, result, 'Tuesday');
    getopeninghours(wednesday, result, 'Wednesday');
    getopeninghours(thursday, result, 'Thursday');
    getopeninghours(friday, result, 'Friday');
    getopeninghours(saturday, result, 'Saturday');
    

  }

  void getopeninghours(List<int> hours, dynamic result, String day) {
    Duration duration;
    for (var i = 0; i < result['opening_times'][day].length; i++) {
      for (var j = 0; j < result['opening_times'][day][0].length; j++) {
        duration = Duration(seconds: result['opening_times'][day][0][j]);
        hours.add(duration.inHours);
      }
    }
  }

  Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');

  if (hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
  }

  return Color(int.parse(hexColor, radix: 16));
}

  

  int get id => storeId;
  String get storename => name;
  String get logo => logoPath;
  String get backgroud => backgroudPath;
  String get description => storeDescription;
  Color get color => backgroundColor;
  List<String> get address => storeAddress;
  List<int> get sundayHours => sunday;
  List<int> get mondayHours => monday;
  List<int> get tuesdayHours => tuesday;
  List<int> get wednesdayHours => wednesday;
  List<int> get thursdayHours => thursday;
  List<int> get fridayHours => friday;
  List<int> get saturdayHours => saturday;

}
