import 'package:cloud_firestore/cloud_firestore.dart';
import 'bike_model.dart';
import 'p2p_payment_model.dart';  // Import the P2P payment model

class NewBikeOrderModel {
  String orderId;
  String userName;
  String userEmail;
  BikeModel bike;
  DateTime orderDate;
  DateTime deliveryDate;
  String orderStatus;
  P2PPaymentModel paymentDetails;  // Add the P2P payment model as a property

  NewBikeOrderModel({
    required this.orderId,
    required this.userName,
    required this.userEmail,
    required this.bike,
    required this.orderDate,
    required this.deliveryDate,
    required this.orderStatus,
    required this.paymentDetails,
  });

  factory NewBikeOrderModel.fromFirestore(Map<String, dynamic> doc) {
    return NewBikeOrderModel(
      orderId: doc['orderId'] as String,
      userName: doc['userName'] as String,
      userEmail: doc['userEmail'] as String,
      bike: BikeModel.fromFirestore(doc['bike'] as Map<String, dynamic>),
      orderDate: (doc['orderDate'] as Timestamp).toDate(),
      deliveryDate: (doc['deliveryDate'] as Timestamp).toDate(),
      orderStatus: doc['orderStatus'] as String,
      paymentDetails: P2PPaymentModel.fromFirestore(doc['paymentDetails'] as Map<String, dynamic>), // Parse the P2P payment details
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'orderId': orderId,
      'userName': userName,
      'userEmail': userEmail,
      'bike': bike.toFirestore(),
      'orderDate': orderDate,
      'deliveryDate': deliveryDate,
      'orderStatus': orderStatus,
      'paymentDetails': paymentDetails.toFirestore(),  // Convert P2P payment details to Firestore format
    };
  }
}
