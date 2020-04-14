import 'package:covidspyapp/builder/CountyInfoListBuilder.dart';
import 'package:covidspyapp/model/CountyInfo.dart';
import 'package:covidspyapp/model/SelectedCounty.dart';
import 'package:covidspyapp/ui/widget/CardViewCountyWidget.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/WebResourceManager.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class CountyInfoPage extends StatelessWidget {
  final SelectedCounty _selectedCounty;

  CountyInfoPage(this._selectedCounty);

  @override
  Widget build(BuildContext context) {
    WebResourceManager<CountyInfo> manager =
        context.fetch<WebResourceManager<CountyInfo>>();
    manager.inFilter.add('');

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          Container(
            height: 50.0,
            child: InkWell(
              onTap: () => Navigator.pop(context, _selectedCounty),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blue,
                  ),
                  Text(
                    'Back',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.green,
          ),
          Divider(),
          Container(
            width: double.infinity,
            height: 50.0,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Color(0xFFEDF0F6),
            child: Text(
              'SELECT COUNTY',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: CountyInfoListBuilder(
              stream: manager.collection$,
              builder: (content, countiesInfo) {
                return ListView.separated(
                  key: ValueKey(SelectedCounty(state: _selectedCounty.state, county: _selectedCounty.county)),
                  itemCount: countiesInfo?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    var countyInfo = countiesInfo[index];

//                    bool isSelectedCounty = _selectedCounty == _selectedCounty;

                    return InkWell(
                        onTap: () {
                          SelectedCounty selectedCounty =  SelectedCounty(county: countyInfo.county, state: countyInfo.state,);
                          Navigator.pop(context, selectedCounty);
                        },
                        child: CardViewCounty(countyInfo: countyInfo, selectedCounty: _selectedCounty,));
//                      ListTile(
//                      title: Text(
//                          '${countiesInfo[index].state}, ${countiesInfo[index].county}'),
//                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
