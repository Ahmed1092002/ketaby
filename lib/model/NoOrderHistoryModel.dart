class NoOrderHistoryModel {
  List<dynamic>? data;
  String? message;
  List<dynamic>? error;
  int? status;

  NoOrderHistoryModel({this.data, this.message, this.error, this.status});

  NoOrderHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <dynamic>[];
      json['data'].forEach((v) {
        data!.add( v.fromJson(v));
      });
    }
    message = json['message'];
    if (json['error'] != null) {
      error = <dynamic>[];
      json['error'].forEach((v) {
        error!.add( v.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    if (this.error != null) {
      data['error'] = this.error!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
