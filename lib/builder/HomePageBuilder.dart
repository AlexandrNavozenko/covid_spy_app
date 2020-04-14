import 'package:covidspyapp/model/SelectedCounty.dart';
import 'package:covidspyapp/utility/ObserverFuture.dart';
import 'package:flutter/material.dart';

class HomePageBuilder extends StatelessWidget {
  @required
  final Function builder;
  final Future future;

  HomePageBuilder({this.builder, this.future});

  @override
  Widget build(BuildContext context) {
    return ObserverFuture<SelectedCounty>(
      future: future,
      onSuccess: (BuildContext context, SelectedCounty data) {
        return builder(context, data);
      },
    );
  }
}
