import 'package:covidspyapp/builder/CountyInfoListBuilder.dart';
import 'package:covidspyapp/model/CountyInfo.dart';
import 'package:covidspyapp/model/SelectedCounty.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/WebResourceManager.dart';
import 'package:sprinkle/SprinkleExtension.dart';

//class CardViewCountyInfoWidget extends StatelessWidget {
//  final SelectedCounty selectedCounty;
//
//  CardViewCountyInfoWidget({this.selectedCounty});
//
//  @override
//  Widget build(BuildContext context) {
//    WebResourceManager<CountyInfo> _manager =
//        context.fetch<WebResourceManager<CountyInfo>>();
//    String filter = selectedCounty.state ?? '';
//    _manager.inFilter.add('');
//
//    return Container(
//      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
//      alignment: Alignment.topLeft,
//      width: double.infinity,
//      height: 80.0,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          CountyInfoListBuilder(
//            stream: _manager.collection$,
//            builder: (content, countiesInfo) {
//              var countyInfo = countiesInfo[0];
//
//              print(
//                  'after filter: ${countyInfo.county}, ${countyInfo.state} !!!');
//              return countyInfo.county != null && countyInfo.state != null
//                  ? Row(
//                      children: <Widget>[
//                        Text(
//                          'County Total ',
//                          style: TextStyle(
//                            fontSize: 16.0,
//                          ),
//                        ),
//                        Text(
//                          countyInfo.cases,
//                          style: TextStyle(
//                            fontSize: 16.0,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                        Text(
//                          ' cases, ',
//                          style: TextStyle(
//                            fontSize: 16.0,
//                          ),
//                        ),
//                        Text(
//                          countyInfo.deaths,
//                          style: TextStyle(
//                            fontSize: 16.0,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                        Text(
//                          ' deaths',
//                          style: TextStyle(
//                            fontSize: 16.0,
//                          ),
//                        ),
//                      ],
//                    )
//                  : Text(
//                      'Select county',
//                      style: TextStyle(color: Colors.redAccent, fontSize: 16.0),
//                    );
//            },
//          ),
//          SizedBox(
//            height: 5.0,
//          ),
//          Text('Data from The New York Times',
//              style: TextStyle(
//                fontStyle: FontStyle.italic,
//              )),
//        ],
//      ),
//    );
//  }
//}
