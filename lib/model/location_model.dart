import 'dart:convert';

class LocationModel {
  String? latitude;
  String? longitude;
  String? city;
  LocationModel({
    this.latitude,
    this.longitude,
    this.city,
  });

  LocationModel copyWith({
    String? latitude,
    String? longitude,
    String? city,
  }) {
    return LocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(latitude != null){
      result.addAll({'latitude': latitude});
    }
    if(longitude != null){
      result.addAll({'longitude': longitude});
    }
    if(city != null){
      result.addAll({'city': city});
    }
  
    return result;
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      latitude: map['latitude'],
      longitude: map['longitude'],
      city: map['city'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) => LocationModel.fromMap(json.decode(source));
}
