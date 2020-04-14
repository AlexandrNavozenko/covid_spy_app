import 'package:covidspyapp/model/CountyInfo.dart';
import 'package:covidspyapp/model/SelectedCounty.dart';
import 'package:flutter/material.dart';

class CardViewCounty extends StatelessWidget {
  final CountyInfo countyInfo;
  final SelectedCounty selectedCounty;


  CardViewCounty({this.countyInfo, this.selectedCounty});

  @override
  Widget build(BuildContext context) {

    bool _isSelectedCounty = countyInfo.state == selectedCounty.state && countyInfo.county == selectedCounty.county;

    return Container(
      alignment: Alignment.center,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${countyInfo.state}, ${countyInfo.county}',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          _isSelectedCounty
              ? Icon(
                  Icons.check,
                  color: Colors.blue,
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
