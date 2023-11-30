class PlaceOrderFailedModel {
  List<dynamic>? data;
  String? message;
  Errors? errors;
  int? status;

  PlaceOrderFailedModel({this.data, this.message, this.errors, this.status});

  PlaceOrderFailedModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Null>[];
      json['data'].forEach((v) {
        data!.add( v.fromJson(v));
      });
    }
    message = json['message'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Errors {
  List<String>? name;
  List<String>? governorateId;
  List<String>? address;
  List<String>? phone;

  Errors({this.name, this.governorateId, this.address, this.phone});

  Errors.fromJson(Map<String, dynamic> json) {
    name = json['name'].cast<String>();
    governorateId = json['governorate_id'].cast<String>();
    address = json['address'].cast<String>();
    phone = json['phone'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['governorate_id'] = this.governorateId;
    data['address'] = this.address;
    data['phone'] = this.phone;
    return data;
  }
}
