import 'dart:io';

import 'package:covidspyapp/builder/CountyInfoBuilder.dart';
import 'package:covidspyapp/builder/HomePageBuilder.dart';
import 'package:covidspyapp/model/CountyInfo.dart';
import 'package:covidspyapp/model/SelectedCounty.dart';
import 'package:covidspyapp/service/CountryInfoService.dart';
import 'package:covidspyapp/service/SelectedCountyService.dart';
import 'package:covidspyapp/ui/CountyInfoPage.dart';
import 'package:flutter/cupertino.dart';
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
  bool _isEnableNotification;

  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    futureSelectedCounty = SelectedCountyService.browse();
    _selectedCounty = await futureSelectedCounty;
    _state = _selectedCounty.state;
    _county = _selectedCounty.county;
    _isEnableNotification = _selectedCounty.isEnableNotification;
    print(
        'initState `SelectedCounty` $_county, $_state, $_isEnableNotification');

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
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 10.0),
              child: Text(
                'Get Push Notification for COVID-19 cases in your country.',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'SELECT COUNTRY',
                style: TextStyle(fontSize: 16.0, color: Colors.black54),
              ),
            ),
            _showCountyInfo(),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              width: 300.0,
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 250.0,
                    color: Colors.red[300],
                    child: Center(
                        child: Text(
                      'AD is here 300x250',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    )),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(top: 5.0),
                    child: InkWell(
                      onTap: () => print('Remove ADS'),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Text(
                          'Remove ADS',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _revolveRaisedButton(),
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
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: 60.0,
      child: CountyInfoBuilder(
        future: futureCountyInfo,
        builder: (content, countyInfo) {
          print(
              'after filter: ${_countyInfo.county}, ${_countyInfo.state}, ${_selectedCounty.isEnableNotification}!!!');

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

  Widget _revolveRaisedButton() {
    return HomePageBuilder(
      future: futureSelectedCounty,
      builder: (content, selectedCounty) {
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              alignment: Alignment.bottomLeft,
              width: double.infinity,
              height: 50.0,
              child: _isEnableNotification
                  ? Text(
                      'Notifications enabled! You are all set.',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    )
                  : SizedBox.shrink(),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 30.0),
              width: double.infinity,
              height: 60.0,
              child: _isEnableNotification
                  ? _raisedButtonExit()
                  : _raisedButtonEnableNotification(),
            ),
//                Container(
//                  width: double.infinity,
//                  height: 30.0,
//                ),
          ],
        );
      },
    );
  }

  Widget _raisedButtonEnableNotification() {
    return RaisedButton(
      color: Color(0xFFEDF0F6),
      textColor: Color(0xFF505050),
      onPressed: () async {
        bool isEnableNotification =
            await SelectedCountyService.commitIsEnableNotification(
                !_isEnableNotification);
        setState(() {
          _isEnableNotification = isEnableNotification;
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Color(0xFF606060), width: 2.0),
      ),
      child: Text(
        'ENABLE NOTIFICATION',
        style: TextStyle(
          color: Color(0xFF606060),
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          letterSpacing: 3.0,
        ),
      ),
    );
  }

  Widget _raisedButtonExit() {
    return RaisedButton(
      color: Color(0xFFEDF0F6),
      onPressed: () => exit(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.red, width: 2.0),
      ),
      child: Text(
        'EXIT',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          letterSpacing: 3.0,
        ),
      ),
    );
  }
}
