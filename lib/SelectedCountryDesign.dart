class SelectedCountryDesign {
  String country;
  String countryCode;
  String slug;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;
  DateTime date;
  SelectedCountryDesign(
      {this.country,
      this.countryCode,
      this.newConfirmed,
      this.newRecovered,
      this.totalConfirmed,
      this.totalRecovered,
      this.totalDeaths,
      this.newDeaths,
      this.date,
      this.slug});
}
