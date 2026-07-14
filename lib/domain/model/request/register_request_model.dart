class RegisterRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNumber;
  String? countryCode;
  String? type;
  String? dateOfBirth;
  String? gender;
  UserAddress? userAddress;
  IdProof? idProof;
  BusinessInfo? businessInfo;
  List<Documents>? documents;
  UserBio? userBio;
  List<SupportServices>? supportServices;

  RegisterRequestModel(
      {this.firstName,
        this.lastName,
        this.email,
        this.password,
        this.phoneNumber,
        this.countryCode,
        this.type,
        this.dateOfBirth,
        this.gender,
        this.userAddress,
        this.idProof,
        this.businessInfo,
        this.documents,
        this.userBio,
        this.supportServices});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    countryCode = json['countryCode'];
    type = json['type'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    userAddress = json['userAddress'] != null
        ? UserAddress.fromJson(json['userAddress'])
        : null;
    idProof =
    json['idProof'] != null ? IdProof.fromJson(json['idProof']) : null;
    businessInfo = json['businessInfo'] != null
        ? BusinessInfo.fromJson(json['businessInfo'])
        : null;
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
    userBio =
    json['userBio'] != null ? UserBio.fromJson(json['userBio']) : null;
    if (json['supportServices'] != null) {
      supportServices = <SupportServices>[];
      json['supportServices'].forEach((v) {
        supportServices!.add(SupportServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['countryCode'] = countryCode;
    data['type'] = type;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    if (userAddress != null) {
      data['userAddress'] = userAddress!.toJson();
    }
    if (idProof != null) {
      data['idProof'] = idProof!.toJson();
    }
    if (businessInfo != null) {
      data['businessInfo'] = businessInfo!.toJson();
    }
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    if (userBio != null) {
      data['userBio'] = userBio!.toJson();
    }
    if (supportServices != null) {
      data['supportServices'] =
          supportServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserAddress {
  String? street1;
  String? suburb;
  String? state;
  String? zipcode;

  UserAddress({this.street1, this.suburb, this.state, this.zipcode});

  UserAddress.fromJson(Map<String, dynamic> json) {
    street1 = json['street1'];
    suburb = json['suburb'];
    state = json['state'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street1'] = street1;
    data['suburb'] = suburb;
    data['state'] = state;
    data['zipcode'] = zipcode;
    return data;
  }
}

class IdProof {
  String? name;
  String? url;
  int? size;
  String? type;
  String? createdAt;

  IdProof({this.name, this.url, this.size, this.type, this.createdAt});

  IdProof.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    size = json['size'];
    type = json['type'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['size'] = size;
    data['type'] = type;
    data['createdAt'] = createdAt;
    return data;
  }
}

class BusinessInfo {
  String? businessName;
  String? activeABN;
  String? acn;
  String? street1;
  String? suburb;
  String? state;
  String? zipcode;

  BusinessInfo(
      {this.businessName,
        this.activeABN,
        this.acn,
        this.street1,
        this.suburb,
        this.state,
        this.zipcode});

  BusinessInfo.fromJson(Map<String, dynamic> json) {
    businessName = json['businessName'];
    activeABN = json['activeABN'];
    acn = json['acn'];
    street1 = json['street1'];
    suburb = json['suburb'];
    state = json['state'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['businessName'] = businessName;
    data['activeABN'] = activeABN;
    data['acn'] = acn;
    data['street1'] = street1;
    data['suburb'] = suburb;
    data['state'] = state;
    data['zipcode'] = zipcode;
    return data;
  }
}

class Documents {
  String? documentType;
  int? documentTypeId;
  List<DocumentUrls>? documentUrls;

  Documents({this.documentType, this.documentTypeId, this.documentUrls});

  Documents.fromJson(Map<String, dynamic> json) {
    documentType = json['documentType'];
    documentTypeId = json['documentTypeId'];
    if (json['documentUrls'] != null) {
      documentUrls = <DocumentUrls>[];
      json['documentUrls'].forEach((v) {
        documentUrls!.add(DocumentUrls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['documentType'] = documentType;
    data['documentTypeId'] = documentTypeId;
    if (documentUrls != null) {
      data['documentUrls'] = documentUrls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class DocumentUrls {
  String? name;
  String? url;
  int? size;
  String? type;
  String? createdAt;

  DocumentUrls({this.name, this.url, this.size, this.type, this.createdAt});

  DocumentUrls.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    size = json['size'];
    type = json['type'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['size'] = size;
    data['type'] = type;
    data['createdAt'] = createdAt;
    return data;
  }
}
class UserBio {
  int? yearsOfExperience;
  String? professionalBio;
  String? experienceInfo;
  bool? newClientAvailability;
  String? degree;
  String? speciality;
  int? primaryLanguageId;
  String? currentEmploymentStatus;
  int? qualificationId;
  String? institute;
  String? yearOfCompleted;
  String? certificationName;
  String? certificationNumber;
  IdProof? certificationDocuments;
  bool? isPetFriendly;
  bool? isNonSmoker;
  bool? isOwnVehicle;
  bool? isEmergencyShift;

  UserBio(
      {this.yearsOfExperience,
        this.professionalBio,
        this.experienceInfo,
        this.newClientAvailability,
        this.degree,
        this.speciality,
        this.primaryLanguageId,
        this.currentEmploymentStatus,
        this.qualificationId,
        this.institute,
        this.yearOfCompleted,
        this.certificationName,
        this.certificationNumber,
        this.certificationDocuments,
        this.isPetFriendly,
        this.isNonSmoker,
        this.isOwnVehicle,
        this.isEmergencyShift});

  UserBio.fromJson(Map<String, dynamic> json) {
    yearsOfExperience = json['yearsOfExperience'];
    professionalBio = json['professionalBio'];
    experienceInfo = json['experienceInfo'];
    newClientAvailability = json['newClientAvailability'];
    degree = json['degree'];
    speciality = json['speciality'];
    primaryLanguageId = json['primaryLanguageId'];
    currentEmploymentStatus = json['currentEmploymentStatus'];
    qualificationId = json['qualificationId'];
    institute = json['institute'];
    yearOfCompleted = json['yearOfCompleted'];
    certificationName = json['certificationName'];
    certificationNumber = json['certificationNumber'];
    certificationDocuments = json['certificationDocuments'] != null
        ? IdProof.fromJson(json['certificationDocuments'])
        : null;
    isPetFriendly = json['isPetFriendly'];
    isNonSmoker = json['isNonSmoker'];
    isOwnVehicle = json['isOwnVehicle'];
    isEmergencyShift = json['isEmergencyShift'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['yearsOfExperience'] = yearsOfExperience;
    data['professionalBio'] = professionalBio;
    data['experienceInfo'] = experienceInfo;
    data['newClientAvailability'] = newClientAvailability;
    data['degree'] = degree;
    data['speciality'] = speciality;
    data['primaryLanguageId'] = primaryLanguageId;
    data['currentEmploymentStatus'] = currentEmploymentStatus;
    data['qualificationId'] = qualificationId;
    data['institute'] = institute;
    data['yearOfCompleted'] = yearOfCompleted;
    data['certificationName'] = certificationName;
    data['certificationNumber'] = certificationNumber;
    if (certificationDocuments != null) {
      data['certificationDocuments'] = certificationDocuments!.toJson();
    }
    data['isPetFriendly'] = isPetFriendly;
    data['isNonSmoker'] = isNonSmoker;
    data['isOwnVehicle'] = isOwnVehicle;
    data['isEmergencyShift'] = isEmergencyShift;
    return data;
  }
}

class SupportServices {
  int? serviceCategoryId;
  int? serviceId;

  SupportServices({this.serviceCategoryId, this.serviceId});

  SupportServices.fromJson(Map<String, dynamic> json) {
    serviceCategoryId = json['serviceCategoryId'];
    serviceId = json['serviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceCategoryId'] = serviceCategoryId;
    data['serviceId'] = serviceId;
    return data;
  }
}
