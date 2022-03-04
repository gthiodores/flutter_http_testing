import 'dart:convert';

class Geo {
  Geo({
    this.lat = "",
    this.lng = "",
  });

  final String lat;
  final String lng;

  Geo copyWith({
    String? lat,
    String? lng,
  }) =>
      Geo(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory Geo.fromRawJson(String str) => Geo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
