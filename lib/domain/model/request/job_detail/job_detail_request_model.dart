class ClientJobDetailRequestModel {
  final int jobId;
  final double applicantsPage;
  final double applicantsLimit;

  ClientJobDetailRequestModel({
    required this.jobId,
    required this. applicantsPage,
    required this.applicantsLimit,
  });

  Map<String, dynamic> toJson() {
    return {
      "jobId": jobId,
      "applicantsPage": applicantsPage,
      "applicantsLimit": applicantsLimit,
    };
  }
}