class DriverProfileModel {
  ProfileResponse? response;

  DriverProfileModel({this.response});

  DriverProfileModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? ProfileResponse.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class ProfileResponse {
  String? message;
  UserData? userData;
  DriverData? driverData;
  String? taxiNameToDisplay;
  int? code;

  ProfileResponse(
      {this.message,
      this.userData,
      this.driverData,
      this.taxiNameToDisplay,
      this.code});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userData =
        json['userData'] != null ? UserData.fromJson(json['userData']) : null;
    driverData = json['driverData'] != null
        ? DriverData.fromJson(json['driverData'])
        : null;
    taxiNameToDisplay = json['taxiNameToDisplay'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (userData != null) {
      data['userData'] = userData!.toJson();
    }
    if (driverData != null) {
      data['driverData'] = driverData!.toJson();
    }
    data['taxiNameToDisplay'] = taxiNameToDisplay;
    data['code'] = code;
    return data;
  }
}

class UserData {
  int? userId;
  String? active;
  String? name;
  String? userType;
  String? email;
  String? phone;
  String? userImage;

  UserData(
      {this.userId,
      this.active,
      this.name,
      this.userType,
      this.email,
      this.phone,
      this.userImage});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    active = json['active'];
    name = json['name'];
    userType = json['user_type'];
    email = json['email'];
    phone = json['phone'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['active'] = this.active;
    data['name'] = this.name;
    data['user_type'] = this.userType;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['user_image'] = this.userImage;
    return data;
  }
}

class DriverData {
  String? active;
  String? isProfileActive;
  String? name;
  String? userType;
  String? email;
  String? phone;
  int? driverId;
  String? driverLat;
  String? driverLng;
  String? profileImage;
  String? drivingLicenceImage;
  String? rating;
  AddressInfo? addressInfo;
  TaxiInfo? taxiInfo;
  TaxiTypeInfo? taxiTypeInfo;
  int? totalRides;
  double? totalEarnings;
  String? stripeId;
  Capabilities? capabilities;
  double? driverAmount;
  double? adminAmount;

  DriverData(
      {this.active,
      this.isProfileActive,
      this.name,
      this.userType,
      this.email,
      this.phone,
      this.driverId,
      this.driverLat,
      this.driverLng,
      this.profileImage,
      this.drivingLicenceImage,
      this.rating,
      this.addressInfo,
      this.taxiInfo,
      this.taxiTypeInfo,
      this.totalRides,
      this.totalEarnings,
      this.stripeId,
      this.capabilities,
      this.driverAmount,
      this.adminAmount});

  DriverData.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    isProfileActive = json['isProfileActive'];
    name = json['name'];
    userType = json['user_type'];
    email = json['email'];
    phone = json['phone'];
    driverId = json['driver_id'];
    driverLat = json['driver_lat'];
    driverLng = json['driver_lng'];
    profileImage = json['profileImage'];
    drivingLicenceImage = json['driving_licence_image'];
    rating = json['rating'];
    addressInfo = json['addressInfo'] != null
        ? new AddressInfo.fromJson(json['addressInfo'])
        : null;
    taxiInfo = json['taxiInfo'] != null
        ? new TaxiInfo.fromJson(json['taxiInfo'])
        : null;
    taxiTypeInfo = json['taxiTypeInfo'] != null
        ? new TaxiTypeInfo.fromJson(json['taxiTypeInfo'])
        : null;
    totalRides = json['totalRides'];
    totalEarnings = json['totalEarnings'];
    stripeId = json['stripe_id'];
    capabilities = json['capabilities'] != null
        ? new Capabilities.fromJson(json['capabilities'])
        : null;
    driverAmount = json['driverAmount'];
    adminAmount = json['adminAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['isProfileActive'] = this.isProfileActive;
    data['name'] = this.name;
    data['user_type'] = this.userType;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['driver_id'] = this.driverId;
    data['driver_lat'] = this.driverLat;
    data['driver_lng'] = this.driverLng;
    data['profileImage'] = this.profileImage;
    data['driving_licence_image'] = this.drivingLicenceImage;
    data['rating'] = this.rating;
    if (this.addressInfo != null) {
      data['addressInfo'] = this.addressInfo!.toJson();
    }
    if (this.taxiInfo != null) {
      data['taxiInfo'] = this.taxiInfo!.toJson();
    }
    if (this.taxiTypeInfo != null) {
      data['taxiTypeInfo'] = this.taxiTypeInfo!.toJson();
    }
    data['totalRides'] = this.totalRides;
    data['totalEarnings'] = this.totalEarnings;
    data['stripe_id'] = this.stripeId;
    if (this.capabilities != null) {
      data['capabilities'] = this.capabilities!.toJson();
    }
    data['driverAmount'] = this.driverAmount;
    data['adminAmount'] = this.adminAmount;
    return data;
  }
}

class AddressInfo {
  int? driverAddressId;
  String? address;
  String? city;
  String? state;
  String? pincode;

  AddressInfo(
      {this.driverAddressId,
      this.address,
      this.city,
      this.state,
      this.pincode});

  AddressInfo.fromJson(Map<String, dynamic> json) {
    driverAddressId = json['driver_address_id'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver_address_id'] = this.driverAddressId;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    return data;
  }
}

class TaxiInfo {
  int? taxiId;
  int? taxiTypeId;
  String? vehicleRegistrationNumber;
  String? vehicleRegistrationImage;
  String? manufacturingDetails;
  String? tagNumberState;
  String? insuranceCompanyInformation;

  TaxiInfo(
      {this.taxiId,
      this.taxiTypeId,
      this.vehicleRegistrationNumber,
      this.vehicleRegistrationImage,
      this.manufacturingDetails,
      this.tagNumberState,
      this.insuranceCompanyInformation});

  TaxiInfo.fromJson(Map<String, dynamic> json) {
    taxiId = json['taxi_id'];
    taxiTypeId = json['taxi_type_id'];
    vehicleRegistrationNumber = json['vehicle_registration_number'];
    vehicleRegistrationImage = json['vehicle_registration_image'];
    manufacturingDetails = json['manufacturing_details'];
    tagNumberState = json['tag_number_state'];
    insuranceCompanyInformation = json['insurance_company_information'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taxi_id'] = this.taxiId;
    data['taxi_type_id'] = this.taxiTypeId;
    data['vehicle_registration_number'] = this.vehicleRegistrationNumber;
    data['vehicle_registration_image'] = this.vehicleRegistrationImage;
    data['manufacturing_details'] = this.manufacturingDetails;
    data['tag_number_state'] = this.tagNumberState;
    data['insurance_company_information'] = this.insuranceCompanyInformation;
    return data;
  }
}

class TaxiTypeInfo {
  String? taxiType;
  String? basePrice;
  String? pricePerKm;
  String? taxiImage;
  int? capacity;
  String? waitingCharges;

  TaxiTypeInfo(
      {this.taxiType,
      this.basePrice,
      this.pricePerKm,
      this.taxiImage,
      this.capacity,
      this.waitingCharges});

  TaxiTypeInfo.fromJson(Map<String, dynamic> json) {
    taxiType = json['taxi_type'];
    basePrice = json['base_price'];
    pricePerKm = json['price_per_km'];
    taxiImage = json['taxi_image'];
    capacity = json['capacity'];
    waitingCharges = json['waiting_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taxi_type'] = this.taxiType;
    data['base_price'] = this.basePrice;
    data['price_per_km'] = this.pricePerKm;
    data['taxi_image'] = this.taxiImage;
    data['capacity'] = this.capacity;
    data['waiting_charges'] = this.waitingCharges;
    return data;
  }
}

class Capabilities {
  String? cardPayments;
  String? transfers;

  Capabilities({this.cardPayments, this.transfers});

  Capabilities.fromJson(Map<String, dynamic> json) {
    cardPayments = json['card_payments'];
    transfers = json['transfers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_payments'] = this.cardPayments;
    data['transfers'] = this.transfers;
    return data;
  }
}
