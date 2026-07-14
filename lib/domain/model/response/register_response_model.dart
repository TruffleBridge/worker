class RegisterResponseModel {
  bool? status;
  String? message;
  Data? data;

  RegisterResponseModel({this.status, this.message, this.data});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? countryCode;
  String? authProvider;
  String? providerId;
  String? profilePicture;
  bool? emailVerified;
  bool? activeStatus;
  bool? deleteStatus;
  String? passwordResetToken;
  String? passwordResetExpiry;
  String? dateOfBirth;
  String? gender;
  IdProof? idProof;
  String? otp;
  String? otpExpiry;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.countryCode,
        this.authProvider,
        this.providerId,
        this.profilePicture,
        this.emailVerified,
        this.activeStatus,
        this.deleteStatus,
        this.passwordResetToken,
        this.passwordResetExpiry,
        this.dateOfBirth,
        this.gender,
        this.idProof,
        this.otp,
        this.otpExpiry,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['countryCode'];
    authProvider = json['authProvider'];
    providerId = json['providerId'];
    profilePicture = json['profilePicture'];
    emailVerified = json['emailVerified'];
    activeStatus = json['activeStatus'];
    deleteStatus = json['deleteStatus'];
    passwordResetToken = json['passwordResetToken'];
    passwordResetExpiry = json['passwordResetExpiry'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    idProof =
    json['idProof'] != null ? IdProof.fromJson(json['idProof']) : null;
    otp = json['otp'];
    otpExpiry = json['otpExpiry'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['countryCode'] = countryCode;
    data['authProvider'] = authProvider;
    data['providerId'] = providerId;
    data['profilePicture'] = profilePicture;
    data['emailVerified'] = emailVerified;
    data['activeStatus'] = activeStatus;
    data['deleteStatus'] = deleteStatus;
    data['passwordResetToken'] = passwordResetToken;
    data['passwordResetExpiry'] = passwordResetExpiry;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    if (idProof != null) {
      data['idProof'] = idProof!.toJson();
    }
    data['otp'] = otp;
    data['otpExpiry'] = otpExpiry;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class IdProof {
  String? url;
  String? name;
  int? size;
  String? type;
  String? createdAt;

  IdProof({this.url, this.name, this.size, this.type, this.createdAt});

  IdProof.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = json['size'];
    type = json['type'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['name'] = name;
    data['size'] = size;
    data['type'] = type;
    data['createdAt'] = createdAt;
    return data;
  }
}
