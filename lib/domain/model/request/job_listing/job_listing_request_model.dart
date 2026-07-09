class ClientJobsRequestModel {
  final String? status; // "active" or "closed"
  final int? page;
  final int? limit;

  ClientJobsRequestModel({
    required this.status,
    this.page = 1,
    this.limit = 10,
  });

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "page": page,
      "limit": limit,
    };
  }
}