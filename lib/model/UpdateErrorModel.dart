class UpdateErrorModel {

  String? message;
  Errors? errors;
  int? status;

  UpdateErrorModel({this.message, this.errors, this.status});

  UpdateErrorModel.fromJson(Map<String, dynamic> json) {

    message = json['message'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Errors {
  List<String>? image;
  List<String>? name;
  List<String>? phone;

  Errors({this.image, this.name, this.phone});

  Errors.fromJson(Map<String, dynamic> json) {
    image = json['image'].cast<String>();
    name = json['name'].cast<String>();
    phone = json['phone'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}
