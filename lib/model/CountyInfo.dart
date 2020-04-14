class CountyInfo {
  final String date;
  final String county;
  final String state;
  final String fips;
  final String cases;
  final String deaths;

  CountyInfo({this.date, this.cases, this.deaths,
    this.county,
    this.state,
    this.fips,
  });

  static CountyInfo fromJson(Map<String, dynamic> json) {
    return CountyInfo(
        date: json['date'],
        county: json['county'],
        state: json['state'],
        fips: json['fips'],
        cases : json['cases'],
        deaths : json['deaths']
    );
  }
}
