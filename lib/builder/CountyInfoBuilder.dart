import 'package:covidspyapp/model/CountyInfo.dart';
import 'package:covidspyapp/utility/ObserverFuture.dart';
import 'package:flutter/material.dart';

class CountyInfoBuilder extends StatelessWidget {
  @required
  final Function builder;
  final Future future;

  CountyInfoBuilder({this.builder, this.future});

  @override
  Widget build(BuildContext context) {
    return ObserverFuture<CountyInfo>(
      future: future,
      onSuccess: (BuildContext context, CountyInfo data) {
        return builder(context, data);
      },
    );
  }
}
