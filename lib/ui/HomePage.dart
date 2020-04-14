import 'package:covidspyapp/builder/HomePageBuilder.dart';
import 'package:covidspyapp/model/SelectedCounty.dart';
import 'package:covidspyapp/service/SelectedCountyService.dart';
import 'package:covidspyapp/ui/CountyInfoPage.dart';
import 'package:covidspyapp/ui/widget/CardViewCountyInfoWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SelectedCounty _selectedCounty;
  Future<SelectedCounty> future;

  void initState() {
    super.initState();
    selectedCountyFetch();
    countyInfoFetch();
  }

  void selectedCountyFetch() async {
    future = SelectedCountyService.browse();
    _selectedCounty = await future;
    print('initState ${_selectedCounty.county}, ${_selectedCounty.state}');
  }

  void countyInfoFetch() {

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
            _testColumn(),
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

//  Widget _showSelectedCounty() {
//    return HomePageBuilder(
//      future: future,
//      builder: (content, tourDetail) {
//        return Text(
//          _selectedCounty != null
//              ? '${_selectedCounty.state}, ${_selectedCounty.county}'
//              : 'Select county',
//          style: TextStyle(
//            fontSize: 18.0,
//          ),
//        );
//      },
//    );
//  }

  Widget _changeSelectedCountyLink() {
    return InkWell(
      onTap: () async {
        SelectedCounty currentCounty = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CountyInfoPage(_selectedCounty),
          ),
        );
        print(
            'before setState ${currentCounty.state}, ${currentCounty.county}');
        SelectedCounty selectedCounty =
            await SelectedCountyService.commit(currentCounty);
        setState(() {
          _selectedCounty = selectedCounty;
          print('setState ${_selectedCounty.state}, ${_selectedCounty.county}');
        });
      },
      child: Text(
        'Change',
        style: TextStyle(
            fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _testColumn() {
    return HomePageBuilder(
      future: future,
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
            CardViewCountyInfoWidget(selectedCounty: _selectedCounty),
          ],
        );
      },
    );
  }
}
