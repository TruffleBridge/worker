class UserModel {
  bool? status;
  String? message;
  Data? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;

  Data({this.user, this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['accessToken'] = accessToken;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? authProvider;
  int? providerId;
  String? profilePicture;
  bool? emailVerified;
  bool? activeStatus;
  bool? deleteStatus;
  String? passwordResetToken;
  String? passwordResetExpiry;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.authProvider,
    this.providerId,
    this.profilePicture,
    this.emailVerified,
    this.activeStatus,
    this.deleteStatus,
    this.passwordResetToken,
    this.passwordResetExpiry,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    authProvider = json['authProvider'];
    providerId = json['providerId'];
    profilePicture = json['profilePicture'];
    emailVerified = json['emailVerified'];
    activeStatus = json['activeStatus'];
    deleteStatus = json['deleteStatus'];
    passwordResetToken = json['passwordResetToken'];
    passwordResetExpiry = json['passwordResetExpiry'];
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
    data['authProvider'] = authProvider;
    data['providerId'] = providerId;
    data['profilePicture'] = profilePicture;
    data['emailVerified'] = emailVerified;
    data['activeStatus'] = activeStatus;
    data['deleteStatus'] = deleteStatus;
    data['passwordResetToken'] = passwordResetToken;
    data['passwordResetExpiry'] = passwordResetExpiry;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
