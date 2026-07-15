class UploadFileResponseModel {
  final bool? status;
  final String? message;
  final UploadedFileData? data;

  const UploadFileResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory UploadFileResponseModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return UploadFileResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? UploadedFileData.fromJson(
        Map<String, dynamic>.from(
          json['data'] as Map,
        ),
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class UploadedFileData {
  final String? name;
  final String? key;
  final String? url;
  final String? signedUrl;
  final int? size;
  final String? createdAt;
  final String? fileType;

  const UploadedFileData({
    this.name,
    this.key,
    this.url,
    this.signedUrl,
    this.size,
    this.createdAt,
    this.fileType,
  });

  factory UploadedFileData.fromJson(
      Map<String, dynamic> json,
      ) {
    return UploadedFileData(
      name: json['name'] as String?,
      key: json['key'] as String?,
      url: json['url'] as String?,
      signedUrl: json['signedUrl'] as String?,
      size: (json['size'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      fileType: json['fileType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'key': key,
      'url': url,
      'signedUrl': signedUrl,
      'size': size,
      'createdAt': createdAt,
      'fileType': fileType,
    };
  }
}