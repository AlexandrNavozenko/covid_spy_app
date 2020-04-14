import 'dart:async';
import 'dart:convert';
import 'package:covidspyapp/model/CountyInfo.dart';
import 'package:http/http.dart' as http;
import 'package:sprinkle/Service.dart';

class CountryInfoService implements Service<CountyInfo>  {
  String _url = 'http://www.mocky.io/v2/5e945ced310000956b5e3084';

  Future<List<CountyInfo>> browse({String filter}) async {

    http.Response response = await http.get(_url);

//    await Future.delayed(Duration(seconds: 2));

    String content = response.body;

    List collection = json.decode(content);

    Iterable<CountyInfo> _countriesInfo = collection.map((_) => CountyInfo.fromJson(_));

    if (filter != null && filter.isNotEmpty) {
      _countriesInfo = _countriesInfo.where((countryInfo) => countryInfo.state.contains(filter));
    }

    return _countriesInfo.toList();
  }
}
