import 'package:covidspyapp/model/CountyInfo.dart';
import 'package:covidspyapp/service/CountryInfoService.dart';
import 'package:covidspyapp/ui/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Overseer.dart';
import 'package:sprinkle/Provider.dart';
import 'package:sprinkle/WebResourceManager.dart';

void main() => runApp(CovidSpy());

class CovidSpy extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      data:  Overseer()
          .register<WebResourceManager<CountyInfo>>(
              () => WebResourceManager<CountyInfo>(CountryInfoService())),
      child: MaterialApp(
        title: 'Covid Spy Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

