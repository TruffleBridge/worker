class ClientJobDetailRequestModel {
  final int jobId;
  final double latitude;
  final double longitude;

  ClientJobDetailRequestModel({
    required this.jobId,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      "jobId": jobId,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}