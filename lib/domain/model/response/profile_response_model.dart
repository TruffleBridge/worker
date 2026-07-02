class ProfileResponseModel {
  bool? status;
  String? message;
  ProfileData? data;

  ProfileResponseModel({this.status, this.message, this.data});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
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

class ProfileData {
  User? user;
  UserBio? userBio;
  List<UserLocation>? userLocation;
  List<UserLanguage>? userLanguage;

  ProfileData({this.user, this.userBio, this.userLocation, this.userLanguage});

  ProfileData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    userBio =
    json['userBio'] != null ? UserBio.fromJson(json['userBio']) : null;
    if (json['userLocation'] != null) {
      userLocation = <UserLocation>[];
      json['userLocation'].forEach((v) {
        userLocation!.add(UserLocation.fromJson(v));
      });
    }
    if (json['userLanguage'] != null) {
      userLanguage = <UserLanguage>[];
      json['userLanguage'].forEach((v) {
        userLanguage!.add(UserLanguage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (userBio != null) {
      data['userBio'] = userBio!.toJson();
    }
    if (userLocation != null) {
      data['userLocation'] = userLocation!.map((v) => v.toJson()).toList();
    }
    if (userLanguage != null) {
      data['userLanguage'] = userLanguage!.map((v) => v.toJson()).toList();
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

  User(
      {this.id,
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
        this.updatedAt});

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

class UserBio {
  int? id;
  int? userId;
  int? yearsOfExperience;
  String? professionalBio;
  String? experienceInfo;
  bool? newClientAvailability;
  String? degree;
  String? speciality;
  String? createdAt;
  String? updatedAt;

  UserBio(
      {this.id,
        this.userId,
        this.yearsOfExperience,
        this.professionalBio,
        this.experienceInfo,
        this.newClientAvailability,
        this.degree,
        this.speciality,
        this.createdAt,
        this.updatedAt});

  UserBio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    yearsOfExperience = json['yearsOfExperience'];
    professionalBio = json['professionalBio'];
    experienceInfo = json['experienceInfo'];
    newClientAvailability = json['newClientAvailability'];
    degree = json['degree'];
    speciality = json['speciality'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['yearsOfExperience'] = yearsOfExperience;
    data['professionalBio'] = professionalBio;
    data['experienceInfo'] = experienceInfo;
    data['newClientAvailability'] = newClientAvailability;
    data['degree'] = degree;
    data['speciality'] = speciality;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class UserLocation {
  int? id;
  int? userId;
  String? street1;
  String? street2;
  String? city;
  String? state;
  String? zipCode;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  UserLocation(
      {this.id,
        this.userId,
        this.street1,
        this.street2,
        this.city,
        this.state,
        this.zipCode,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt});

  UserLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    street1 = json['street1'];
    street2 = json['street2'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['street1'] = street1;
    data['street2'] = street2;
    data['city'] = city;
    data['state'] = state;
    data['zipCode'] = zipCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class UserLanguage {
  int? id;
  String? name;
  bool? status;
  String? createdAt;
  String? updatedAt;

  UserLanguage(
      {this.id, this.name, this.status, this.createdAt, this.updatedAt});

  UserLanguage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
