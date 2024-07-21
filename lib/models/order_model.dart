import 'package:cloud_firestore/cloud_firestore.dart';

import 'bike_model.dart';

class OrderModel {
  String orderId;
  String userName;
  String userEmail;
  String contactInfo;
  String address;
  BikeModel bike;
  DateTime orderDate;
  DateTime deliveryDate;
  String orderStatus;
  double totalPrice;
  String paymentMethod;

  OrderModel({
    required this.orderId,
    required this.userName,
    required this.userEmail,
    required this.contactInfo,
    required this.address,
    required this.bike,
    required this.orderDate,
    required this.deliveryDate,
    required this.orderStatus,
    required this.totalPrice,
    required this.paymentMethod,
  });

  factory OrderModel.fromFirestore(Map<String, dynamic> doc) {
    return OrderModel(
      orderId: doc['orderId'] as String,
      userName: doc['userName'] as String,
      userEmail: doc['userEmail'] as String,
      contactInfo: doc['contactInfo'] as String,
      address: doc['address'] as String,
      bike: BikeModel.fromFirestore(doc['bike'] as Map<String, dynamic>),
      orderDate: (doc['orderDate'] as Timestamp).toDate(),
      deliveryDate: (doc['deliveryDate'] as Timestamp).toDate(),
      orderStatus: doc['orderStatus'] as String,
      totalPrice: doc['totalPrice'] as double,
      paymentMethod: doc['paymentMethod'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'orderId': orderId,
      'userName': userName,
      'userEmail': userEmail,
      'contactInfo': contactInfo,
      'address': address,
      'bike': bike.toFirestore(),
      'orderDate': orderDate,
      'deliveryDate': deliveryDate,
      'orderStatus': orderStatus,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
    };
  }
}
