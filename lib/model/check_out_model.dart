class CheckOutModel {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  CheckOutModel({this.data, this.message, this.error, this.status});

  CheckOutModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    if (this.error != null) {
      data['error'] = this.error!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  User? user;
  String? total;
  List<CartItems>? cartItems;

  Data({this.id, this.user, this.total, this.cartItems});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    total = json['total'];
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['total'] = this.total;
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? userId;
  String? userName;
  String? userEmail;
  String? address;
  String? phone;

  User({this.userId, this.userName, this.userEmail, this.address, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['address'] = this.address;
    data['phone'] = this.phone;
    return data;
  }
}

class CartItems {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductPrice;
  int? itemQuantity;
  String? itemTotal;

  CartItems(
      {this.itemId,
        this.itemProductId,
        this.itemProductName,
        this.itemProductPrice,
        this.itemQuantity,
        this.itemTotal});

  CartItems.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemProductId = json['item_product_id'];
    itemProductName = json['item_product_name'];
    itemProductPrice = json['item_product_price'];
    itemQuantity = json['item_quantity'];
    itemTotal = json['item_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['item_product_id'] = this.itemProductId;
    data['item_product_name'] = this.itemProductName;
    data['item_product_price'] = this.itemProductPrice;
    data['item_quantity'] = this.itemQuantity;
    data['item_total'] = this.itemTotal;
    return data;
  }
}
