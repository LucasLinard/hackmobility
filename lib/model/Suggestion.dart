class Suggestion {
  String label;
  String language;
  String countryCode;
  String locationId;
  Map<String, String> address;
  String matchLevel;

  Suggestion(
      {this.label,
      this.language,
      this.countryCode,
      this.locationId,
      this.address,
      this.matchLevel});

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      label: json["label"],
      language: json["language"],
      countryCode: json["countryCode"],
      locationId: json["locationId"],
      address: json["address"],
      matchLevel: json["matchLevel"],
    );
  }
}
