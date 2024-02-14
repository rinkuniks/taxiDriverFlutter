class BookingModel {
  RideResponse? response;

  BookingModel({this.response});

  BookingModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? RideResponse.fromJson(json['response'])
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

class RideResponse {
  String? message;
  RideData? rideData;
  UserData? userData;
  // DriverData? driverData;
  TaxiData? taxiData;
  // FareData? fareData;
  int? code;

  RideResponse(
      {this.message, this.rideData, this.userData, this.taxiData, this.code});

  RideResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    rideData =
        json['rideData'] != null ? RideData.fromJson(json['rideData']) : null;
    userData =
        json['userData'] != null ? UserData.fromJson(json['userData']) : null;
    // driverData = json['driverData'] != null ? DriverData.fromJson(json['driverData']) : null;
    taxiData =
        json['taxiData'] != null ? TaxiData.fromJson(json['taxiData']) : null;
    // fareData =
    //     json['fareData'] != null ? FareData.fromJson(json['fareData']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (rideData != null) {
      data['rideData'] = rideData!.toJson();
    }
    if (userData != null) {
      data['userData'] = userData!.toJson();
    }
    // if (driverData != null) {
    //   data['driverData'] = driverData!.toJson();
    // }
    if (taxiData != null) {
      data['taxiData'] = taxiData!.toJson();
    }
    // if (fareData != null) {
    //   data['fareData'] = fareData!.toJson();
    // }
    data['code'] = code;
    return data;
  }
}

class RideData {
  int? rideId;
  String? rideType;
  String? rideStatus;
  String? confirmed;
  String? pickupAddress;
  String? dropAddress;
  String? pickupLat;
  String? pickupLng;
  String? dropLat;
  String? dropLng;
  // Null? pickupTime;
  // Null? dropTime;
  // Null? comments;
  // Null? tips;
  String? estimatedCost;
  String? actualCost;
  String? estimatedTax;
  dynamic? rideFare;
  String? payBy;
  // Null? parcelName;
  // Null? parcelHeight;
  // Null? parcelWidth;
  // Null? parcelDepth;
  // Null? parcelWeight;
  // String? cancel;
  String? cancelReason;
  String? cancelType;
  // String? advanceRide;
  // int? rating;
  // int? userRating;
  String? distance;
  // String? paymentStatus;
  // String? bookingThrough;
  // int? checkDriverRating;

  RideData({
    this.rideId,
    this.rideType,
    this.rideStatus,
    this.confirmed,
    this.pickupAddress,
    this.dropAddress,
    this.pickupLat,
    this.pickupLng,
    this.dropLat,
    this.dropLng,
    // this.pickupTime,
    // this.dropTime,
    // this.comments,
    // this.tips,
    this.estimatedCost,
    this.actualCost,
    this.estimatedTax,
    this.rideFare,
    this.payBy,
    // this.parcelName,
    // this.parcelHeight,
    // this.parcelWidth,
    // this.parcelDepth,
    // this.parcelWeight,
    // this.cancel,
    this.cancelReason,
    this.cancelType,
    // this.advanceRide,
    // this.rating,
    // this.userRating,
    this.distance,
    // this.paymentStatus,
    // this.bookingThrough,
    // this.checkDriverRating
  });

  RideData.fromJson(Map<String, dynamic> json) {
    rideId = json['ride_id'];
    rideType = json['ride_type'];
    rideStatus = json['ride_status'];
    confirmed = json['confirmed'];
    pickupAddress = json['pickup_address'];
    dropAddress = json['drop_address'];
    pickupLat = json['pickup_lat'];
    pickupLng = json['pickup_lng'];
    dropLat = json['drop_lat'];
    dropLng = json['drop_lng'];
    // pickupTime = json['pickup_time'];
    // dropTime = json['drop_time'];
    // comments = json['comments'];
    // tips = json['tips'];
    estimatedCost = json['estimated_cost'];
    actualCost = json['actual_cost'];
    estimatedTax = json['estimated_tax'];
    rideFare = json['ride_fare'];
    payBy = json['pay_by'];
    // parcelName = json['parcel_name'];
    // parcelHeight = json['parcel_height'];
    // parcelWidth = json['parcel_width'];
    // parcelDepth = json['parcel_depth'];
    // parcelWeight = json['parcel_weight'];
    // cancel = json['cancel'];
    cancelReason = json['cancel_reason'];
    cancelType = json['cancel_type'];
    // advanceRide = json['advanceRide'];
    // rating = json['rating'];
    // userRating = json['user_rating'];
    distance = json['distance'];
    // paymentStatus = json['payment_status'];
    // bookingThrough = json['booking_through'];
    // checkDriverRating = json['check_driver_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ride_id'] = rideId;
    data['ride_type'] = rideType;
    data['ride_status'] = rideStatus;
    data['confirmed'] = confirmed;
    data['pickup_address'] = pickupAddress;
    data['drop_address'] = dropAddress;
    data['pickup_lat'] = pickupLat;
    data['pickup_lng'] = pickupLng;
    data['drop_lat'] = dropLat;
    data['drop_lng'] = dropLng;
    // data['pickup_time'] = pickupTime;
    // data['drop_time'] = dropTime;
    // data['comments'] = comments;
    // data['tips'] = tips;
    data['estimated_cost'] = estimatedCost;
    data['actual_cost'] = actualCost;
    data['estimated_tax'] = estimatedTax;
    data['ride_fare'] = rideFare;
    data['pay_by'] = payBy;
    // data['parcel_name'] = parcelName;
    // data['parcel_height'] = parcelHeight;
    // data['parcel_width'] = parcelWidth;
    // data['parcel_depth'] = parcelDepth;
    // data['parcel_weight'] = parcelWeight;
    // data['cancel'] = cancel;
    data['cancel_reason'] = cancelReason;
    data['cancel_type'] = cancelType;
    // data['advanceRide'] = advanceRide;
    // data['rating'] = rating;
    // data['user_rating'] = userRating;
    // data['distance'] = distance;
    // data['payment_status'] = paymentStatus;
    // data['booking_through'] = bookingThrough;
    // data['check_driver_rating'] = checkDriverRating;
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
  int? walletAmount;
  String? userImage;
  String? rating;
  String? cardDetail;
  int? cardLimit;

  UserData(
      {this.userId,
      this.active,
      this.name,
      this.userType,
      this.email,
      this.phone,
      this.walletAmount,
      this.userImage,
      this.rating,
      this.cardDetail,
      this.cardLimit});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    active = json['active'];
    name = json['name'];
    userType = json['user_type'];
    email = json['email'];
    phone = json['phone'];
    walletAmount = json['wallet_amount'];
    userImage = json['user_image'];
    rating = json['rating'];
    cardDetail = json['card_detail'];
    cardLimit = json['card_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['active'] = active;
    data['name'] = name;
    data['user_type'] = userType;
    data['email'] = email;
    data['phone'] = phone;
    data['wallet_amount'] = walletAmount;
    data['user_image'] = userImage;
    data['rating'] = rating;
    data['card_detail'] = cardDetail;
    data['card_limit'] = cardLimit;
    return data;
  }
}

// class DriverData {
//
//
//   DriverData({});
//
// DriverData.fromJson(Map<String, dynamic> json) {
// }
//
// Map<String, dynamic> toJson() {
// final Map<String, dynamic> data = <String, dynamic>{};
// return data;
// }
// }

class TaxiData {
  // Null? taxiId;
  // Null? active;
  String? vehicleRegistrationNumber;
  // Null? vehicleRegistrationImage;
  // Null? manufacturingDetails;
  // Null? tagNumberState;
  // Null? insuranceCompanyInformation;
  TaxiTypeInfo? taxiTypeInfo;

  TaxiData(
      {
      //   this.taxiId,
      // this.active,
      this.vehicleRegistrationNumber,
      // this.vehicleRegistrationImage,
      // this.manufacturingDetails,
      // this.tagNumberState,
      // this.insuranceCompanyInformation,
      this.taxiTypeInfo});

  TaxiData.fromJson(Map<String, dynamic> json) {
    // taxiId = json['taxi_id'];
    // active = json['active'];
    vehicleRegistrationNumber = json['vehicle_registration_number'];
    // vehicleRegistrationImage = json['vehicle_registration_image'];
    // manufacturingDetails = json['manufacturing_details'];
    // tagNumberState = json['tag_number_state'];
    // insuranceCompanyInformation = json['insurance_company_information'];
    taxiTypeInfo = json['taxiTypeInfo'] != null
        ? TaxiTypeInfo.fromJson(json['taxiTypeInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['taxi_id'] = taxiId;
    // data['active'] = active;
    data['vehicle_registration_number'] = vehicleRegistrationNumber;
    // data['vehicle_registration_image'] = vehicleRegistrationImage;
    // data['manufacturing_details'] = manufacturingDetails;
    // data['tag_number_state'] = tagNumberState;
    // data['insurance_company_information'] = insuranceCompanyInformation;
    if (taxiTypeInfo != null) {
      data['taxiTypeInfo'] = taxiTypeInfo!.toJson();
    }
    return data;
  }
}

class TaxiTypeInfo {
  int? taxiTypeId;
  String? active;
  String? taxiName;
  String? basePrice;
  String? pricePerKm;
  String? taxiImage;

  TaxiTypeInfo(
      {this.taxiTypeId,
      this.active,
      this.taxiName,
      this.basePrice,
      this.pricePerKm,
      this.taxiImage});

  TaxiTypeInfo.fromJson(Map<String, dynamic> json) {
    taxiTypeId = json['taxi_type_id'];
    active = json['active'];
    taxiName = json['taxi_name'];
    basePrice = json['base_price'];
    pricePerKm = json['price_per_km'];
    taxiImage = json['taxi_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taxi_type_id'] = taxiTypeId;
    data['active'] = active;
    data['taxi_name'] = taxiName;
    data['base_price'] = basePrice;
    data['price_per_km'] = pricePerKm;
    data['taxi_image'] = taxiImage;
    return data;
  }
}

class FareData {
  Null? rideFare;
  String? waitingCharge;
  Null? tips;
  Null? tax;
  Null? totalBill;
  int? isModify;

  FareData(
      {this.rideFare,
      this.waitingCharge,
      this.tips,
      this.tax,
      this.totalBill,
      this.isModify});

  FareData.fromJson(Map<String, dynamic> json) {
    rideFare = json['ride_fare'];
    waitingCharge = json['waiting_charge'];
    tips = json['tips'];
    tax = json['tax'];
    totalBill = json['total_bill'];
    isModify = json['isModify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ride_fare'] = rideFare;
    data['waiting_charge'] = waitingCharge;
    data['tips'] = tips;
    data['tax'] = tax;
    data['total_bill'] = totalBill;
    data['isModify'] = isModify;
    return data;
  }
}
