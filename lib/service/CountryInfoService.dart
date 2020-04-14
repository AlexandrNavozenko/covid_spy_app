import 'dart:async';
import 'dart:convert';
import 'package:covidspyapp/model/CountyInfo.dart';
import 'package:http/http.dart' as http;
import 'package:sprinkle/Service.dart';

class CountryInfoService implements Service<CountyInfo>  {
  String _url = 'http://www.mocky.io/v2/5e95b0d62f0000560002536e';

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

  Future<CountyInfo> singleBrowse({String state, String county}) async {
    Iterable<CountyInfo> _countiesInfoIterable;
    CountyInfo _countyInfo;
    List<CountyInfo> _countiesInfo = await browse();

    if (county != null && county.isNotEmpty) {
      _countiesInfoIterable = _countiesInfo.where((f) => f.county.contains(county)); //.where((countryInfo) => countryInfo.county.contains(state))
    }

    if (state != null && state.isNotEmpty) {
      _countyInfo = _countiesInfoIterable.singleWhere((countryInfo) => countryInfo.state.contains(state), orElse: () => null);
    }

    return _countyInfo;
  }
}
