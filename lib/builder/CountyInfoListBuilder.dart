import 'package:covidspyapp/model/CountyInfo.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';

class CountyInfoListBuilder extends StatelessWidget {
  @required
  final Function builder;
  final Stream stream;

  CountyInfoListBuilder({this.builder, this.stream});

  @override
  Widget build(BuildContext context) {
    return Observer<List<CountyInfo>>(
      stream: stream,
      onSuccess: (BuildContext context, List<CountyInfo> data) =>
          builder(context, data),
    );
  }
}
