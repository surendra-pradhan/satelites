import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  List _satelites = [];
  List get satelites {
    return [..._satelites];
  }

  Map<String, dynamic> _satelite = {};

  Map<String, dynamic> get satelite {
    return _satelite;
  }

  Future setAndFetchSatelites() async {
    var request = http.Request(
        'GET', Uri.parse('https://tle.ivanstanojevic.me/api/tle/'));

    try {
      http.StreamedResponse response = await request.send();

      final responsData = await response.stream.bytesToString();

      final res = json.decode(responsData);

      _satelites = res["member"];
      print(_satelites);

      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future setandfetchSateliteDetails(id) async {
    var request = http.Request(
        'GET', Uri.parse('https://tle.ivanstanojevic.me/api/tle/$id'));

    try {
      http.StreamedResponse response = await request.send();

      final responsData = await response.stream.bytesToString();

      final res = json.decode(responsData);

      _satelite = res;
      print(_satelite);

      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }
}
