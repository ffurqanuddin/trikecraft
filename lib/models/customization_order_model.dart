import 'package:cloud_firestore/cloud_firestore.dart';

class CustomizationOrderModel {
  String orderId;
  String userName;
  String userEmail;
  String contactInfo;
  String address;
  bool selfStart;
  bool roof;
  String color;
  int seats;
  String engineCc;
  String brake; // "hand" or "feet"
  String gear; // "hand" or "feet"
  String transmission; // "shaft" or "chain"
  int totalPrice;
  DateTime orderDate;
  String orderStatus;
  String extraDetail;

  CustomizationOrderModel(
      {required this.orderId,
      required this.userName,
      required this.userEmail,
      required this.contactInfo,
      required this.address,
      required this.selfStart,
      required this.roof,
      required this.color,
      required this.seats,
      required this.engineCc,
      required this.brake,
      required this.gear,
      required this.transmission,
      required this.totalPrice,
      required this.orderDate,
      required this.orderStatus,
      required this.extraDetail});

  factory CustomizationOrderModel.fromFirestore(Map<String, dynamic> doc) {
    return CustomizationOrderModel(
        orderId: doc['orderId'] as String,
        userName: doc['userName'] as String,
        userEmail: doc['userEmail'] as String,
        contactInfo: doc['contactInfo'] as String,
        address: doc['address'] as String,
        selfStart: doc['selfStart'] as bool,
        roof: doc['roof'] as bool,
        color: doc['color'] as String,
        seats: doc['seats'] as int,
        engineCc: doc['engineCc'] as String,
        brake: doc['brake'] as String,
        gear: doc['gear'] as String,
        transmission: doc['transmission'] as String,
        totalPrice: doc['totalPrice'] as int,
        orderDate: (doc['orderDate'] as Timestamp).toDate(),
        orderStatus: doc['orderStatus'] as String,
        extraDetail: doc["extraDetail"] as String);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'orderId': orderId,
      'userName': userName,
      'userEmail': userEmail,
      'contactInfo': contactInfo,
      'address': address,
      'selfStart': selfStart,
      'roof': roof,
      'color': color,
      'seats': seats,
      'engineCc': engineCc,
      'brake': brake,
      'gear': gear,
      'transmission': transmission,
      'totalPrice': totalPrice,
      'orderDate': orderDate,
      'orderStatus': orderStatus,
      'extraDetail': extraDetail
    };
  }
}
