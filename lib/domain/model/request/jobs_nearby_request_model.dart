class JobsNearbyRequestModel {
  int? page;
  int? limit;
  String? search;
  String? locationType;
  double? latitude;
  double? longitude;
  String? address;
  int? radiusKm;

  JobsNearbyRequestModel({
    this.page,
    this.limit,
    this.search,
    this.locationType,
    this.latitude,
    this.longitude,
    this.address,
    this.radiusKm,
  });

  JobsNearbyRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    search = json['search'];
    locationType = json['locationType'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    radiusKm = json['radiusKm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['search'] = search;
    data['locationType'] = locationType;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['radiusKm'] = radiusKm;
    return data;
  }
}
