import 'package:covidspyapp/builder/CountyInfoBuilder.dart';
import 'package:covidspyapp/builder/HomePageBuilder.dart';
import 'package:covidspyapp/model/CountyInfo.dart';
import 'package:covidspyapp/model/SelectedCounty.dart';
import 'package:covidspyapp/service/CountryInfoService.dart';
import 'package:covidspyapp/service/SelectedCountyService.dart';
import 'package:covidspyapp/ui/CountyInfoPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SelectedCounty _selectedCounty;
  CountyInfo _countyInfo;
  Future<SelectedCounty> futureSelectedCounty;
  Future<CountyInfo> futureCountyInfo;
  String _state;
  String _county;

  void initState() {
    super.initState();
    fetch();
//    fetchCountyInfo(state: _state, county: _county);
  }

  void fetch() async {
    futureSelectedCounty = SelectedCountyService.browse();
    _selectedCounty = await futureSelectedCounty;
    _state = _selectedCounty.state;
    _county = _selectedCounty.county;
    print('initState `SelectedCounty` $_county, $_state');

    futureCountyInfo =
        CountryInfoService().singleBrowse(state: _state, county: _county);
    _countyInfo = await futureCountyInfo;
    print('initState `CountyInfo` ${_countyInfo.county}, ${_countyInfo.state}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF0F6),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 120.0,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(120.0),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 10.0, 20.0),
              child: Text(
                'Get Push Notification for COVID-19 cases in your country.',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'SELECT COUNTRY',
                style: TextStyle(fontSize: 18.0, color: Colors.black54),
              ),
            ),
            _showCountyInfo(),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 300.0,
                    height: 250.0,
                    color: Colors.red[300],
                    child: Center(
                        child: Text(
                      'AD is here 300x250',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _changeSelectedCountyLink() {
    return InkWell(
      onTap: () async {
        CountyInfo countyInfo = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                CountyInfoPage(_countyInfo, _selectedCounty),
          ),
        );
        print('before setState ${countyInfo.state}, ${countyInfo.county}');

        SelectedCounty currentCounty =
            SelectedCounty(state: countyInfo.state, county: countyInfo.county);
        SelectedCounty selectedCounty =
            await SelectedCountyService.commit(currentCounty);

        setState(() {
          _countyInfo = countyInfo;
          print(
              'setState `CountyInfo` ${_countyInfo.state}, ${_countyInfo.county}');

          _selectedCounty = selectedCounty;
          print(
              'setState `SelectedCounty` ${_selectedCounty.state}, ${_selectedCounty.county}');
        });
      },
      child: Text(
        'Change',
        style: TextStyle(
            fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _showCountyInfo() {
    return HomePageBuilder(
      future: futureSelectedCounty,
      builder: (content, selectedCounty) {
        return Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    selectedCounty != null
                        ? '${_selectedCounty.state}, ${_selectedCounty.county}'
                        : 'Select county',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  _changeSelectedCountyLink(),
                ],
              ),
            ),
            _cardViewCountyInfoWidget(),
          ],
        );
      },
    );
  }

  Widget _cardViewCountyInfoWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: 80.0,
      child: CountyInfoBuilder(
        future: futureCountyInfo,
        builder: (content, countyInfo) {
          print(
              'after filter: ${_countyInfo.county}, ${_countyInfo.state} !!!');

          return _countyInfo.county != null && _countyInfo.state != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'County Total ',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            _countyInfo.cases,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' cases, ',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            _countyInfo.deaths,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' deaths',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Data from The New York Times',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ])
              : Text(
                  'Select county',
                  style: TextStyle(color: Colors.red),
                );
        },
      ),
    );
  }
}
