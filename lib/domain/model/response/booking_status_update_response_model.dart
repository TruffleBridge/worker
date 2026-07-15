class BookingStatusUpdateResponseModel {
  bool? status;
  String? message;
  List<int>? data;

  BookingStatusUpdateResponseModel({this.status, this.message, this.data});

  BookingStatusUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
